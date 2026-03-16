# ---------------- #
# Install Homebrew #
# ---------------- #

# Check for homebrew and install if absent
install_homebrew() {
    # Color codes: try tput, fallback to ANSI
    local blue=$(tput setaf 4 2>/dev/null || echo -e "\033[34m")
    local yellow=$(tput setaf 3 2>/dev/null || echo -e "\033[33m")
    local green=$(tput setaf 2 2>/dev/null || echo -e "\033[32m")

    func_header "Status" "Installing Homebrew."

    # Checking installation first
    if [[ -f "/opt/homebrew/bin/brew" ]]; then
        func_info "$yellow" "Homebrew" "Homebrew is already installed."
    else
        func_info "$blue" "Homebrew" "No installation found. Downloading and installing Homebrew."
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi

    # Happy success message :)
    func_info "$green" "Homebrew" "Homebrew installation operational."
}

# Run the installation functions if script is called
install_homebrew
