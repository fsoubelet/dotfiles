# -------------------------------- #
# Brew and System Update Functions #
# -------------------------------- #




# Full run of keeping everything Homebrew-related up to date
brewup() {
    # Color codes: try tput, fallback to ANSI
    local yellow=$(tput setaf 3 2>/dev/null || echo -e "\033[33m")
    local green=$(tput setaf 2 2>/dev/null || echo -e "\033[32m")

    func_header "Status" "Updating Homebrew."
    brew update
    func_info "$yellow" "Homebrew" "Homebrew Updated."

    func_header "Status" "Upgrading formulae and casks."
    brew upgrade
    func_info "$yellow" "Homebrew" "Formulae Upgraded."

    func_header "Status" "Cleaning up old kegs and checking symlinks."
    brew cleanup
    func_info "$yellow" "Homebrew" "Cleaned up."

    func_header "Status" "Removing formulae no longer needed."
    brew autoremove
    func_info "$yellow" "Homebrew" "Unneeded formulae removed."

    func_header "Status" "Checking installation."
    brew doctor
    func_info "$yellow" "Brewup" "Please read and acknowledge the warnings."
    func_info "$green" "Homebrew" "Set and ready to go!"
}


# Getting a status updates on new packages versions and software updates
whatsnew () {
    # Start with a display and silently update homebrew
    func_header "Status" "Checking Homebrew packages..."
    brew update >/dev/null 2>&1

    # Query for outdated homebrew packages and casks
    new_packages=$(brew outdated --quiet; brew outdated --cask --quiet)
    num_packages=$(echo "$new_packages" | grep -cve '^\s*$')  # count non-empty lines

    # If there are some new ones, display them
    if [[ "$num_packages" -gt 0 ]]; then
        func_info "Homebrew" "New package updates available:"
        while IFS= read -r package; do
            printf "   * %s\n" "$package" >&2
        done <<< "$new_packages"
    else
        func_info "Homebrew" "No new package updates available."
    fi

    # Add an empty line before macOS section
    printf "\n" >&2  # print blank line to stderr

    # Now check for macOS software updates
    func_header "Status" "Checking for macOS software updates..."
    mac_updates=$(softwareupdate -l 2>/dev/null | tail -n +5)

    # If there are some new ones, display them
    if [[ -n "$mac_updates" ]]; then
        func_info "macOS" "Updates available:"
        echo "$mac_updates" | while IFS= read -r line; do
            printf "   * %s\n" "$line" >&2
        done
    else
        func_info "macOS" "No macOS updates available."
    fi
}
