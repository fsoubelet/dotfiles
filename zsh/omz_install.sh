#! /bin/bash

# ---------------------------- #
# Install Oh-My-Zsh if Absent  #
# ---------------------------- #

func_header "Status" "Installing Oh-My-Zsh."

# Checking if oh-my-zsh installation exists first
if [[ -d "${HOME}/.oh-my-zsh" ]]
    then
        echo "Oh-my-zsh is already installed."
    else
        echo "No installation found. Downloading and installing oh-my-zsh."
        RUNZSH=no CHSH=no KEEP_ZSHRC=yes \
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# -------------------------- #
# Install Plugins if Absent  #
# -------------------------- #

func_header "Status" "Installing Plugins."

# Modify this list as desired
plugins=(
  "https://github.com/zdharma-continuum/fast-syntax-highlighting"
  "https://github.com/zsh-users/zsh-autosuggestions"
)

for repo in "${plugins[@]}"; do
    name=$(basename "$repo")
    dir="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/${name}"

    # Check if plugin directory exists first
    if [[ -d "$dir" ]]; then
        echo "$name already installed."
    else
        echo "Installing $name plugin."
        git clone --depth=1 "$repo" "$dir"
    fi
done
