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


# Clean Python mess anywhere
clean() {
    # Gives us the option to dry run if desired
    local dry_run=false
    if [[ "$1" == "--dry-run" ]]; then
        dry_run=true
        shift
    fi

  # Define directory and file patterns to remove
  local files=( '*.py[co]' 'fc.*' 'fort.*' '.coverage*' 'coverage.xml' )
  local dirs=( '__pycache__' '__marimo__' '*.pytest_cache' '*.mypy_cache' '*.ruff_cache' '*.ipynb_checkpoints' '*dist' )

  # We clean up the files (or display if dry run)
  func_info "Cleanup" "Removing Python bytecode, test artifacts and coverage files..."
  for file in "${files[@]}"; do
    if $dry_run; then
      # fd --type f --glob --hidden "$file"
      find . -type f -name "$file" -print
    else
      # fd --type f --glob --hidden "$file" --exec rm -f {}
      find . -type f -name "$file" -delete
    fi
  done

  # We clean up the directories (or display if dry run)
  func_info "Cleanup" "Removing Python caches, test artifacts and coverage directories..."
  for dir in "${dirs[@]}"; do
    if $dry_run; then
      # fd --type d --glob --hidden "$dir"
      find . -type f -name "$file" -print
    else
      # fd --type d --glob --hidden "$dir" --exec rm -rf {}
      find . -type f -name "$file" -delete
    fi
  done

  func_info "Cleanup" "All cleaned up!"
}


# Turning hidden files on/off in Finder
hiddenOn() { defaults write com.apple.Finder AppleShowAllFiles YES ; }
hiddenOff() { defaults write com.apple.Finder AppleShowAllFiles NO ; }


# Viewing man pages in Preview
pman() {
    local ps
    ps=$(mktemp -t manpageXXXX).ps

    if man -t "$@" > "$ps"; then
        open "$ps"
    else
        echo "Man page not found: $*" >&2
        rm -f "$ps"
        return 1
    fi

    # Optional: clean up after opening (may delete too early if Preview keeps it open)
    # trap 'rm -f "$ps"' EXIT
}


# Prompting IP addresses of all active network interfaces
myip() {
  # Color codes (use tput if available, fallback to ANSI)
  local yellow=$(tput setaf 3 2>/dev/null || echo -e "\033[33m")
  local cyan=$(tput setaf 6 2>/dev/null || echo -e "\033[36m")
  local green=$(tput setaf 2 2>/dev/null || echo -e "\033[32m")
  local reset=$(tput sgr0 2>/dev/null || echo -e "\033[0m")

  # Loop over all active interfaces
  for interface in $(ifconfig -l); do
    # Skip empty or non-existent interfaces
    if ! ifconfig "$interface" &>/dev/null; then
      continue
    fi

    # Extract IPv4 addresses
    while read -r line; do
      addr=$(awk '{print $2}' <<< "$line")
      printf "%-8s (IPv4): %s%s%s\n" "$interface" "$yellow" "$addr" "$reset"
    done < <(ifconfig "$interface" | awk '$1=="inet" && $2!="127.0.0.1"')

    # Extract IPv6 addresses
    while read -r line; do
      addr=$(awk '{print $2}' <<< "$line")
      printf "%-8s (IPv6): %s%s%s\n" "$interface" "$cyan" "$addr" "$reset"
    done < <(ifconfig "$interface" | awk '$1=="inet6" && $2!="::1"')
  done

  # Show a small separator line
  printf "\n"

  # Get and display public IP address
  local public_ip
  public_ip=$(curl -s ifconfig.me || echo "Unavailable")
  if [[ -n "$public_ip" ]]; then
    printf "%-8s (Public): %s%s%s\n" "WAN" "$green" "$public_ip" "$reset"
  fi
}


# Using streamlink to pull a stream and send it to iina
getstream() {
  streamlink --stdout "$1" best | iina --stdin # First and only argument should be url to the stream
}


# Convert every flac file in current directory into mp3 format
flac_to_mp3() {
  fd --extension flac -x ffmpeg -n -i {} -q:a 0 {.}.mp3
}


# Convert every mov file in current directory into mp4 format
# The stream is copied, which preserves arbitrary frame rate
mov_to_mp4() {
  fd --extension mov -x ffmpeg -y -hide_banner -loglevel error -i {} -c copy {.}.mp4
}


# Convert every mp4 file in current directory into mkv format
# The stream is copied, which preserves arbitrary frame rate
mp4_to_mkv() {
  fd --extension mp4 -x ffmpeg -y -hide_banner -loglevel error -i {} -c copy {.}.mkv
}


# Convert every mkv file in current directory into mp4 format
# The stream is copied, which preserves arbitrary frame rate
mkv_to_mp4() {
  fd --extension mkv -x ffmpeg -y -hide_banner -loglevel error -i {} -c copy {.}.mp4
}
