#######################
# PERSONNAL FUNCTIONS #
#######################

# A header print for homebrew update steps
func_header() {
  local tag="$1"; shift
  local fmt="$1"; shift

  # Color codes: try tput, fallback to ANSI
  local purple=$(tput setaf 5 2>/dev/null || echo -e "\033[35m")
  local reset=$(tput sgr0 2>/dev/null || echo -e "\033[0m")

  echo "---------------------------------------------------------" >&2
  printf "%s%s:%s %s\n" "$purple" "$tag" "$reset" "$fmt" >&2
  echo "---------------------------------------------------------" >&2
}


# A simple display with [tag] first
func_info() {
  local tag="$1"; shift
  local fmt="$1"; shift

  # Color codes: try tput, fallback to ANSI
  local yellow=$(tput setaf 3 2>/dev/null || echo -e "\033[33m")
  local reset=$(tput sgr0 2>/dev/null || echo -e "\033[0m")

  # Print with yellow tag in [] and then the rest of the message
  printf "\n%s[%s]%s %s\n" "$yellow" "$tag" "$reset" "$fmt" "$@" >&2
}


# Full run of keeping everything Homebrew-related up to date
brewup() {
  func_header "Status" "Updating Homebrew."
  brew update
  func_info "HOMEBREW" "Homebrew Updated."

  func_header "Status" "Upgrading formulae and casks."
  brew upgrade
  func_info "HOMEBREW" "Formulae Upgraded."

  func_header "Status" "Cleaning up old kegs and checking symlinks."
  brew cleanup
  func_info "HOMEBREW" "Cleaned up."

  func_header "Status" "Removing formulae no longer needed."
  brew autoremove
  func_info "HOMEBREW" "Unneeded formulae removed."

  func_header "Status" "Checking installation."
  brew doctor
  func_info "HOMEBREW" "Set and ready to go!"
  func_info "BREWUP" "Please read and acknowledge the warnings."
}


# Getting a status updates on new packages versions and software updates
whatsnew () {
  echo "Checking homebrew packages..."
  brew update > /dev/null;
  new_packages=$(brew outdated --quiet; brew outdated --cask --quiet)
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
