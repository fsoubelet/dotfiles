#! /bin/bash

# Checking if Homebrew installation exists (executable is here)
if [[ -d "${HOME}/.oh-my-zsh" ]]
then
    echo "Oh-my-zsh is already installed."
else
    echo "No installation found. Downloading and installing oh-my-zsh."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi


# Checking for fast-syntax-highlighting plugin (install if necessary)
if [[ -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/fast-syntax-highlighting" ]]
then
    echo "The fast-syntax-highlighting plugin is already installed."
else
    echo "Downloading and installing fast-syntax-highlighting."
    sh -c "$(git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/fast-syntax-highlighting)"
fi

# Checking for zsh-autosuggestions plugin (install if necessary)
if [[ -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions" ]]
then
    echo "The zsh-autosuggestions plugin is already installed."
else
    echo "Downloading and installing zsh-autosuggestions."
    sh -c "$(git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions)"
fi
