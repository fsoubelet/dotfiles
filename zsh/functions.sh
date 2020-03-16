#######################
# PERSONNAL FUNCTIONS #
#######################


# A convenient way to print some statements
function_echo() {
  local fmt="$1"; shift
  # shellcheck disable=SC2059
  echo "---------------------------------------------------------"
  echo "$(tput setaf 5) Status: $fmt $(tput sgr 0)" "$@"
  echo "---------------------------------------------------------"
}

function_info() {
  local fmt="$1"; shift
  # shellcheck disable=SC2059
  printf "\\n[HOMEBREW] $fmt\\n" "$@"
}


# An easier du utility
inspect() {
  for folder in *; do du -sh $folder; done
}

# Nuclear bomb utility, beware!
wipe() {
  read "choice?This will remove ALL elements in the current directory, are you sure? [y/n] "
  case "$choice" in
    y|Y|yes|YES) for element in *; do th $element; done && echo "Cleaned directory.";;
    n|N|no|NO) echo "Aborting";;
    *) echo "This is an invalid choice, aborting.";;
  esac
}

# Viewing man pages in Preview
pman() { ps=$(mktemp -t manpageXXXX).ps ; man -t "$@" > "$ps" ; open "$ps" ; }


# Prompting IP address
myip() {
  ifconfig lo0 | grep 'inet ' | sed -e 's/:/ /' | awk '{print "lo0       : " $2}'
  ifconfig en0 | grep 'inet ' | sed -e 's/:/ /' | awk '{print "en0 (IPv4): " $2 " " $3 " " $4 " " $5 " " $6}'
  ifconfig en0 | grep 'inet6 ' | sed -e 's/ / /' | awk '{print "en0 (IPv6): " $2 " " $3 " " $4 " " $5 " " $6}'
  ifconfig en1 | grep 'inet ' | sed -e 's/:/ /' | awk '{print "en1 (IPv4): " $2 " " $3 " " $4 " " $5 " " $6}'
  ifconfig en1 | grep 'inet6 ' | sed -e 's/ / /' | awk '{print "en1 (IPv6): " $2 " " $3 " " $4 " " $5 " " $6}'
}


# Convert every flac file in current directory into mp3 format
flac_to_mp3() {
  for FILE in *.flac; do
      ffmpeg -i "$FILE" -q:a 0 "${FILE/.flac/.mp3}"
  done
}


# Convert every mov file in current directory into mp4 format
mov_to_mp4() {
  for file in *.mov;
  do
    ffmpeg -i "$file" -r 25 "${file%.mov.mp4}.mp4"
    trash "$file"
  done
}


# Convert every mp4 file in current directory into mkv format
mp4_to_mkv() {
  for file in *.mp4;
  do
    ffmpeg -i "$file" -r 25 "${file%.mov.mp4}.mkv"
    trash "$file"
  done
}

# Convert every mkv file in current directory into mp4 format
mkv_to_mp4() {
  for file in *.mkv;
  do
    ffmpeg -i "$file" -r 25 "$file%.mp4.mkv}.mkv"
    trash "$file"
  done
}
