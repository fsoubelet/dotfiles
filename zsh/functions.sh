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

# Full run of keeping everything Homebrew-related up to date
function brewup() {
  function_echo "Updating Homebrew."
  brew update
  function_info "Homebrew Updated."

  function_echo "Upgrading Homebrew."
  brew upgrade
  function_info "Homebrew Upgraded."

  function_echo "Checking and establishing symlinks."
  brew prune -v
  function_info "Done."

  function_echo "Cleaning up old kegs."
  brew cleanup
  function_info "Cleaned up."

  function_echo "Checking installation."
  brew doctor
  function_info "Set and ready to go!"
  printf "[BREWUP] Please read and acknowledge the warnings.\\n"
}


# Turning hidden files on/off in Finder
function hiddenOn() { defaults write com.apple.Finder AppleShowAllFiles YES ; }
function hiddenOff() { defaults write com.apple.Finder AppleShowAllFiles NO ; }


# Viewing man pages in Preview
function pman() { ps=`mktemp -t manpageXXXX`.ps ; man -t "$@" > "$ps" ; open "$ps" ; }


# Prompting IP address
function myip() {
  ifconfig lo0 | grep 'inet ' | sed -e 's/:/ /' | awk '{print "lo0       : " $2}'
	ifconfig en0 | grep 'inet ' | sed -e 's/:/ /' | awk '{print "en0 (IPv4): " $2 " " $3 " " $4 " " $5 " " $6}'
	ifconfig en0 | grep 'inet6 ' | sed -e 's/ / /' | awk '{print "en0 (IPv6): " $2 " " $3 " " $4 " " $5 " " $6}'
	ifconfig en1 | grep 'inet ' | sed -e 's/:/ /' | awk '{print "en1 (IPv4): " $2 " " $3 " " $4 " " $5 " " $6}'
	ifconfig en1 | grep 'inet6 ' | sed -e 's/ / /' | awk '{print "en1 (IPv6): " $2 " " $3 " " $4 " " $5 " " $6}'
}


# Getting a status updates on new packages versions and software updates
function whatsnew() {
  # homebrew
  echo "Checking homebrew packages..."
  brew update > /dev/null;
  new_packages=$(brew outdated --quiet; brew cask outdated --quiet)
  num_packages=$(echo $new_packages | wc -w)
  if [ $num_packages -gt 0 ]; then
      echo "New package updates available:"
      for package in $new_packages; do
  	echo "   * $package";
      done
  else
      echo "No new package updates available."
  fi
  # macOS
  echo "Checking macOS updates..."
  softwareupdate -l | tail +5
}


# Convert every flac file in current directory into mp3 format
function flac_to_mp3() {
  # Written to run in the same directory of the .flac files.
  for FILE in *.flac; do
      ffmpeg -i "$FILE" -q:a 0 "${FILE/.flac/.mp3}"
  done
}


# Convert every mov file in current directory into mp4 format
function mov_to_mp4() {
  # Written to fun in the same directory of the .mov files.
  for file in *.mov;
  do
    ffmpeg -i "$file" -r 30 "${file%.mov.mp4}.mp4"
    trash $file
  done
}


# Autoconnect to starbucks wifi network
function connect_to_starbucks() {
  # Make sure we have a network connection.
  curl -s -o /dev/null http://www.google.com
  if [ $? -ne 0 ]
  then
     echo "Can't resolve host."
     exit 1
  fi

  APNAME=`curl -s -o /dev/null -w "%{redirect_url}\n" http://www.google.com | grep -o "apname.*"`

  # Already authenticated.
  if [ -z $APNAME ]
  then
      echo "Connected."
      exit 0
  else
      echo "Connecting..."
  fi

  # Attempt authentication.
  SUBMIT_URL=http://sbux-portal.appspot.com/submit
  AUTHENTICATED=`curl -s -F $APNAME $SUBMIT_URL | grep -oh "sbux-portal-authenticated"`

  if [ $AUTHENTICATED = "sbux-portal-authenticated" ]
  then
      echo "Successfully connected."
      exit 0
  else
      echo "Connection failed."
      exit 1
  fi
}
