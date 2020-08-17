#######################
# PERSONNAL FUNCTIONS #
#######################

# ANSI escape sequences for bold, cyan, dark blue, end, pink and red.
#B = \033[1m
#C = \033[96m
#D = \033[34m
#E = \033[0m
#P = \033[95m
#R = \033[31m

# An easier du utility
inspect() {
  for folder in *; do du -sh $folder; done
}

# Nuclear bomb utility, beware!
wipe() {
  if [ -n "$BASH" ]; then read -r -p "This will remove ALL elements in the current directory, are you sure? [y/n] " choice; fi
  if [ -n "$ZSH_NAME" ]; then read "choice?This will remove ALL elements in the current directory, are you sure? [y/n] "; fi
  case "$choice" in
    y|Y|yes|YES) for element in *; do rm -rf $element; done && echo "Cleaned directory." ;;
    n|N|no|NO) echo "Aborting.";;
    *) echo "This is an invalid choice, aborting.";;
  esac
}

# Launching the Betabeat GUI
gui_prod() {
  echo -e "\033[1mINFO:\033[0m You should be on the technical network for this."
  echo -e "Launching BetaBeat GUI through \033[31mjws\033[0m, with source: \033[96mhttp://bewww.cern.ch/ap/deployments/applications/cern/lhc/lhc-app-beta-beating/PRO/lhc-app-beta-beating-BetaBeating-Control-3t.jnlp\033[0m \n"
  /mcr/bin/jws http://bewww.cern.ch/ap/deployments/applications/cern/lhc/lhc-app-beta-beating/PRO/lhc-app-beta-beating-BetaBeating-Control-3t.jnlp
}

gui_dev() {
  echo -e "\033[1mINFO:\033[0m You should be on the technical network for this."
  echo -e "Launching BetaBeat GUI through \033[31mjava\033[0m, with source: \033[96m/afs/cern.ch/eng/sl/lintrack/bb_gui_20200226.jar\033[0m \n"
  java -jar /afs/cern.ch/eng/sl/lintrack/bb_gui_20200226.jar
}

# Viewing man pages in Preview
pman() { ps=`mktemp -t manpageXXXX`.ps ; man -t "$@" > "$ps" ; open "$ps" ; }

# Stop any of my pending jobs on lxplus
stop_pending() {
  condor_rm `bjobs -u fesoubel | grep PEND | cut -f1 -d" "`
}

# Prompting IP address
myip() {
  ifconfig lo0 | grep 'inet ' | sed -e 's/:/ /' | awk '{print "lo0       : " $2}'
	ifconfig en0 | grep 'inet ' | sed -e 's/:/ /' | awk '{print "en0 (IPv4): " $2 " " $3 " " $4 " " $5 " " $6}'
	ifconfig en0 | grep 'inet6 ' | sed -e 's/ / /' | awk '{print "en0 (IPv6): " $2 " " $3 " " $4 " " $5 " " $6}'
	ifconfig en1 | grep 'inet ' | sed -e 's/:/ /' | awk '{print "en1 (IPv4): " $2 " " $3 " " $4 " " $5 " " $6}'
	ifconfig en1 | grep 'inet6 ' | sed -e 's/ / /' | awk '{print "en1 (IPv6): " $2 " " $3 " " $4 " " $5 " " $6}'
}
