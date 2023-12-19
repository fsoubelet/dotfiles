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
brewup() {
  function_echo "Updating Homebrew."
  brew update
  function_info "Homebrew Updated."

  function_echo "Upgrading formulae and casks."
  brew upgrade
  function_info "Formulae Upgraded."

  function_echo "Cleaning up old kegs and checking symlinks."
  brew cleanup
  function_info "Cleaned up."

  function_echo "Checking installation."
  brew doctor
  function_info "Set and ready to go!"
  printf "[BREWUP] Please read and acknowledge the warnings.\\n"
}


# Unix specific aliases, work on both MacOS and Linux.
pbcopy() {
	stdin=$(</dev/stdin);
	pbcopy="$(which pbcopy)";
	if [[ -n "$pbcopy" ]]; then
		echo "$stdin" | "$pbcopy"
	else
		echo "$stdin" | xclip -selection clipboard
	fi
}

pbpaste() {
	pbpaste="$(which pbpaste)";
	if [[ -n "$pbpaste" ]]; then
		"$pbpaste"
	else
		xclip -selection clipboard
	fi
}


# An easier du utility
inspect() {
  if [[ $# -eq 0 ]]
  then
    echo "No arguments were provided, please provided the directory to inspect."
    echo "Examples:"
    echo "          inspect <dir_name>"
    echo "          inspect ."
    echo "          inspect ~/"
  elif [[ ! -d "$1" ]]
  then
    echo "There is no such directory."
  else
    for folder in "$1"/*; do du -sh "$folder"; done
  fi
}


# Nuclear bomb, but should be ok with 'th'
wipe() {
  if [[ -n "$BASH" ]]; then read -r -p "This will remove ALL elements in the current directory, are you sure? [y/n] " choice; fi
  if [[ -n "$ZSH_NAME" ]]; then "choice?This will remove ALL elements in the current directory, are you sure? [y/n] "; fi
  case "$choice" in
    y|Y|yes|YES) for element in *; do th "$element"; done;;
    n|N|no|NO) echo "Aborting.";;
    *) echo "This is an invalid choice, aborting.";;
  esac
}


# Clean Python mess anywhere
clean() {
  function_echo "Cleaning up bytecode files and python cache."
  find . -type f -name '*.py[co]' -delete -o -type d -name __pycache__ -delete

  function_echo "Cleaning up pytest cache & test artifacts."
  find . -type d -name '*.pytest_cache' -exec rm -rf {} + -o -type f -name '*.pytest_cache' -exec rm -rf {} +
  find . -type f -name 'fc.*' -delete -o -type f -name 'fort.*' -delete

  function_echo "Cleaning up mypy and ruff caches."
  find . -type d -name "*.mypy_cache" -exec rm -rf {} +
  find . -type d -name "*.ruff_cache" -exec rm -rf {} +

  function_echo "Cleaning ipython notebook caches"
  find . -type d -name "*.ipynb_checkpoints" -exec rm -rf {} +

  function_echo "Cleaning up coverage reports."
  find . -type f -name '.coverage*' -exec rm -rf {} + -o -type f -name 'coverage.xml' -delete

  function_echo "Cleaning up package builds."
  find . -type d -name "*dist" -exec rm -rf {} +

  function_echo "All cleaned up."
}


# An attempt at a parallel version of the above
fclean() {
  function_echo "Cleaning up bytecode files and python cache."
  fd --type f --extension "py[co]" --exec rm -rf
  fd --glob __pycache__ --exec rm -rf

  function_echo "Cleaning up pytest cache & test artifacts."
  fd --type d --extension pytest_cache --exec rm -rf
  fd --type f --extension pytest_cache --exec rm -rf
  fd --type f --glob "fc.*" --exec rm -rf
  fd --type f --glob "fort.*" --exec rm -rf

  function_echo "Cleaning up mypy and ruff caches."
  fd --type d --extension mypy_cache --exec rm -rf
  fd --type d --extension ruff_cache --exec rm -rf

  function_echo "Cleaning up ipython notebook caches."
  fd --type d --extension ipynb_checkpoints --exec rm -rf

  function_echo "Cleaning up coverage reports."
  fd --type f --extension "coverage*" --exec rm -rf
  fd --type f --glob "coverage.xml" --exec rm -rf

  function_echo "Cleaning up package builds."
  fd --glob "*dist"  --exec rm -rf

  function_echo "All cleaned up."
}


# Turning hidden files on/off in Finder
hiddenOn() { defaults write com.apple.Finder AppleShowAllFiles YES ; }
hiddenOff() { defaults write com.apple.Finder AppleShowAllFiles NO ; }


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


# Getting a status updates on new packages versions and software updates
whatsnew () {
  echo "Checking homebrew packages..."
  brew update > /dev/null;
  new_packages=$(brew outdated --quiet; brew cask outdated --quiet)
  num_packages=$(echo "$new_packages" | wc -w)
  if [[ "$num_packages" -gt 0 ]]; then
      echo "New package updates available:"
      for package in ${new_packages}; do
  	echo "   * $package";
      done
  else
      echo "No new package updates available."
  fi
  echo "Checking macOS updates..."
  softwareupdate -l | tail +5
}

# Using streamlink to pull a stream and send it to iina
getstream() {
  streamlink --stdout "$1" best | iina --stdin # First and only argument should be url to the stream
}


# Convert every flac file in current directory into mp3 format
flac_to_mp3() {
  fd --extension flac --exec ffmpeg -i {} -q:a 0 {.}.mp3
}


# Convert every mov file in current directory into mp4 format
mov_to_mp4() {
  fd --extension mov --exec ffmpeg -i {} -r 25 {.}.mp4
}


# Convert every mp4 file in current directory into mkv format
mp4_to_mkv() {
  fd --extension mp4 --exec ffmpeg -i {} -r 25 {.}.mkv
}


# Convert every mkv file in current directory into mp4 format
mkv_to_mp4() {
  fd --extension mkv --exec ffmpeg -i {} -r 25 {.}.mp4
}
