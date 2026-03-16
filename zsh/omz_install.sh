# ----------------------------- #
# Install Oh-My-Zsh and Plugins #
# ----------------------------- #

# Check for oh-my-zsh and install if absent
install_oh_my_zsh() {
    # Color codes: try tput, fallback to ANSI
    local blue=$(tput setaf 4 2>/dev/null || echo -e "\033[34m")
    local yellow=$(tput setaf 3 2>/dev/null || echo -e "\033[33m")
    local green=$(tput setaf 2 2>/dev/null || echo -e "\033[32m")

    func_header "Status" "Installing Oh-My-Zsh."

    # Checking installation first
    if [[ -d "$HOME/.oh-my-zsh" ]]; then
        func_info "$yellow" "Oh-My-Zsh" "Oh-My-Zsh is already installed."
    else
        func_info "$blue" "Oh-My-Zsh" "No installation found. Downloading and installing oh-my-zsh."
        RUNZSH=no CHSH=no KEEP_ZSHRC=yes \
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    fi

    # Happy success message :)
    func_info "$green" "Oh-My-Zsh" "Oh-My-Zsh installation operational."
}


# Installing oh-my-zsh plugins if absent
install_omz_plugins() {
    # Modify this list as desired
    local plugins=(
        "https://github.com/zdharma-continuum/fast-syntax-highlighting"
        "https://github.com/zsh-users/zsh-autosuggestions"
    )

    # Color codes: try tput, fallback to ANSI
    local yellow=$(tput setaf 3 2>/dev/null || echo -e "\033[33m")
    local green=$(tput setaf 2 2>/dev/null || echo -e "\033[32m")

    func_header "Status" "Installing Oh-My-Zsh Plugins."

    # We loop nicely through each defined plugin
    for repo in "${plugins[@]}"; do
        # Extract the plugin name and target directory
        local basename=$(basename "$repo")
        local dir="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/${basename}"

        # Check if plugin directory exists first
        if [[ -d "$dir" ]]; then
            func_info "$yellow" "Plugins" "$basename is already installed."
        else
            func_info "$yellow" "Plugins" "Installing $basename plugin."
            git clone --depth=1 "$repo" "$dir" >/dev/null 2>&1  # silence git output
        fi
    done

    # Happy success message :)
    func_info "$green" "Plugins" "Oh-My-Zsh plugins installation complete."
}


# Run the installation functions if script is called
install_oh_my_zsh
install_omz_plugins
