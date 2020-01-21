#! /bin/bash

# Checking if Homebrew installation exists (executable is here)
if [[ -f "/usr/local/bin/brew" ]]
then
    echo "Homebrew is already installed."
else
    echo "No installation found. Downloading and installing Homebrew."
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi