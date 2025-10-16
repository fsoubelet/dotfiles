#######################
# PERSONNAL FUNCTIONS #
#######################

# A convenient way to print some statements
fecho() {
  local fmt="$1"; shift

  # Color codes: try tput, fallback to ANSI
  local purple=$(tput setaf 5 2>/dev/null || echo -e "\033[35m")
  local reset=$(tput sgr0 2>/dev/null || echo -e "\033[0m")

  # shellcheck disable=SC2059
  echo "---------------------------------------------------------"
  printf "%sStatus:%s %s\n" "$purple" "$reset" "$fmt"
  echo "---------------------------------------------------------"
}

finfo() {
  local fmt="$1"; shift
  # shellcheck disable=SC2059
  printf "\\n[HOMEBREW] $fmt\\n" "$@"
}

# Full run of keeping everything Homebrew-related up to date
brewup() {
  fecho "Updating Homebrew."
  brew update
  finfo "Homebrew Updated."

  fecho "Upgrading formulae and casks."
  brew upgrade
  finfo "Formulae Upgraded."

  fecho "Cleaning up old kegs and checking symlinks."
  brew cleanup
  finfo "Cleaned up."

  fecho "Removing formulae no longer needed."
  brew autoremove
  finfo "Unneeded formulae removed."

  fecho "Checking installation."
  brew doctor
  finfo "Set and ready to go!"
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
