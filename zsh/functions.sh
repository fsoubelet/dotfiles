#######################
# PERSONNAL FUNCTIONS #
#######################

# A header print for homebrew update steps
brew_header() {
  local fmt="$1"; shift

  # Color codes: try tput, fallback to ANSI
  local purple=$(tput setaf 5 2>/dev/null || echo -e "\033[35m")
  local reset=$(tput sgr0 2>/dev/null || echo -e "\033[0m")

  # shellcheck disable=SC2059
  echo "---------------------------------------------------------" >&2
  printf "%sStatus:%s %s\n" "$purple" "$reset" "$fmt" >&2
  echo "---------------------------------------------------------" >&2
}

brew_info() {
  local fmt="$1"; shift

  # Color codes: try tput, fallback to ANSI
  local yellow=$(tput setaf 3 2>/dev/null || echo -e "\033[33m")
  local reset=$(tput sgr0 2>/dev/null || echo -e "\033[0m")

  printf "\n%s[HOMEBREW]%s %s\n" "$yellow" "$reset" "$fmt" "$@" >&2
}

# Full run of keeping everything Homebrew-related up to date
brewup() {
  brew_header "Updating Homebrew."
  brew update
  brew_info "Homebrew Updated."

  brew_header "Upgrading formulae and casks."
  brew upgrade
  brew_info "Formulae Upgraded."

  brew_header "Cleaning up old kegs and checking symlinks."
  brew cleanup
  brew_info "Cleaned up."

  brew_header "Removing formulae no longer needed."
  brew autoremove
  brew_info "Unneeded formulae removed."

  brew_header "Checking installation."
  brew doctor
  brew_info "Set and ready to go!"
  printf "[BREWUP] Please read and acknowledge the warnings.\\n"
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
