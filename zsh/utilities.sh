# ----------------------- #
# SMALL UTILITY FUNCTIONS #
# ----------------------- #

# An easier 'du' utility
inspect() {
  # Color codes (use tput if available, fallback to ANSI)
  local yellow=$(tput setaf 3 2>/dev/null || echo -e "\033[33m")
  local reset=$(tput sgr0 2>/dev/null || echo -e "\033[0m")

  # Check argument presence
  if [[ $# -eq 0 ]]; then
    echo "No arguments were provided, provide a directory to inspect."
    echo "Usage: inspect <directory>"
    echo "Examples:"
    echo "  inspect <dir_name>"
    echo "  inspect ."
    echo "  inspect ~/"
    return 1
  fi

  local dir=$1

  # Check provided argument is a directory
  if [[ ! -d "$dir" ]]; then
    echo "${yellow}Error:${reset} '$dir' is not a directory."
    return 1
  fi

  # Use a nullglob-like behavior for bash compatibility
  # (zsh does this by default, and 2>/dev/null || true
  # prevents errors if shopt isn’t available).
  shopt -s nullglob 2>/dev/null || true
  local items=("$dir"/*)

  # Handle empty directories gracefully
  if [[ ${#items[@]} -eq 0 ]]; then
    echo "${yellow}Directory '$dir' is empty.${reset}"
    return 0
  fi

  # We can now loop through the items in that dir for their sizes
  # The first line requires GNU parallel (otherwise use the for loop)
  printf '%s\n' "${items[@]}" | parallel -j "$(sysctl -n hw.ncpu)" --keep-order du -sh {} 2>/dev/null
  # for item in "${items[@]}"; do
  #   du -sh "$item" 2>/dev/null
  # done
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
  fecho "Cleaning up bytecode files and python cache."
  find . -type f -name '*.py[co]' -delete -o -type d -name __pycache__ -delete
  find . -type d -name __marimo__ -delete

  fecho "Cleaning up pytest cache & test artifacts."
  find . -type d -name '*.pytest_cache' -exec rm -rf {} + -o -type f -name '*.pytest_cache' -exec rm -rf {} +
  find . -type f -name 'fc.*' -delete -o -type f -name 'fort.*' -delete

  fecho "Cleaning up mypy and ruff caches."
  find . -type d -name "*.mypy_cache" -exec rm -rf {} +
  find . -type d -name "*.ruff_cache" -exec rm -rf {} +

  fecho "Cleaning ipython notebook caches"
  find . -type d -name "*.ipynb_checkpoints" -exec rm -rf {} +

  fecho "Cleaning up coverage reports."
  find . -type f -name '.coverage*' -exec rm -rf {} + -o -type f -name 'coverage.xml' -delete

  fecho "Cleaning up package builds."
  find . -type d -name "*dist" -exec rm -rf {} +

  fecho "All cleaned up."
}


# An attempt at a parallel version of the above
fclean() {
  fecho "Cleaning up bytecode files and python cache."
  fd --type f --extension "py[co]" --exec rm -rf
  fd --glob __pycache__ --exec rm -rf

  fecho "Cleaning up pytest cache & test artifacts."
  fd --type d --extension pytest_cache --exec rm -rf
  fd --type f --extension pytest_cache --exec rm -rf
  fd --type f --glob "fc.*" --exec rm -rf
  fd --type f --glob "fort.*" --exec rm -rf

  fecho "Cleaning up mypy and ruff caches."
  fd --type d --extension mypy_cache --exec rm -rf
  fd --type d --extension ruff_cache --exec rm -rf

  fecho "Cleaning up ipython notebook caches."
  fd --type d --extension ipynb_checkpoints --exec rm -rf

  fecho "Cleaning up coverage reports."
  fd --type f --extension "coverage*" --exec rm -rf
  fd --type f --glob "coverage.xml" --exec rm -rf

  fecho "Cleaning up package builds."
  fd --glob "*dist"  --exec rm -rf

  fecho "All cleaned up."
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
