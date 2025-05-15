#! /bin/bash

# Checking if Homebrew installation exists (executable is here)
if [[ -f "/opt/homebrew/bin/brew" ]]
then
    echo "Homebrew is already installed."
else
    echo "No installation found. Downloading and installing Homebrew."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi
