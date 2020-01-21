#! /bin/bash

# Checking if Homebrew installation exists (executable is here)
if [[ -d "${HOME}/.oh-my-zsh" ]]
then
    echo "Oh-my-zsh is already installed."
else
    echo "No installation found. Downloading and installing oh-my-zsh."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi