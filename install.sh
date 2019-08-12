#!/usr/bin/env bash

################################################################################
# Install
#
# This script installs software and symlinks dotfiles into the home directory.
################################################################################


##########################
# Useful print functions #
##########################
dotfiles_echo() {
  local fmt="$1"; shift
  # shellcheck disable=SC2059
  echo "---------------------------------------------------------"
  echo "$(tput setaf 5) DOTFILES: $fmt $(tput sgr 0)" "$@"
  echo "---------------------------------------------------------"
}


dotfiles_info() {
  local fmt="$1"; shift
  # shellcheck disable=SC2059
  printf "\\n[DOTFILES] $fmt\\n" "$@"
}


info () {
  printf "\r  [ \033[00;34m..\033[0m ] $1\n"
}


user () {
  printf "\r  [ \033[0;33m??\033[0m ] $1\n"
}

success () {
  printf "\r\033[2K  [ \033[00;32mOK\033[0m ] $1\n"
}

fail () {
  printf "\r\033[2K  [\033[0;31mFAIL\033[0m] $1\n"
  echo ''
  exit
}

set -e # Terminate script if anything exits with a non-zero value


####################
# Define locations #
####################
DOTFILES_DIR=$HOME/dotfiles
VIM_DIR=$HOME/.vim


############################################################
# Install homebrew if necessary and then homebrew packages #
############################################################
dotfiles_echo "Checking for Homebrew installation."
brew="/usr/local/bin/brew"
if [ -f "$brew" ]; then
  dotfiles_info "Homebrew is installed."
else
  dotfiles_info "Installing Homebrew. Homebrew requires macOS command line tools, please make sure to download Xcode first."
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

dotfiles_echo "Installing Homebrew packages."
brew bundle "$DOTFILES_DIR"/"macos"/"Brewfile"


#################################
# Check for a clean git install #
#################################
localGit="/usr/local/bin/git"
if ! [[ -f "$localGit" ]]; then
  dotfiles_echo "Invalid git installation. Aborting. Please intall git."
  exit 1
fi


######################
# Installing colorls #
######################
dotfiles_info "Installing colorls."
gem install colorls


#####################
# Install oh-my-zsh #
#####################
dotfiles_echo "Installing oh-my-zsh."
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
else
  dotfiles_info "oh-my-zsh already installed."
fi


##############################
# Preparing spaceship prompt #
##############################
dotfiles_echo "Preparing Spaceship prompt."
git clone https://github.com/denysdovhan/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt"
ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"


####################################
# Setup all dotfiles with symlinks #
####################################

dotfiles_echo "Installing dotfiles..."
dotfiles_echo "Creating backup for existing files."

git_files=(
"gitconfig"
"gitignore_global"
)

for file in "${git_files[@]}"; do
  if [ -f "$HOME"/."$file" ]; then
    dotfiles_info ".$file already present. Backing up..."
    cp "$HOME"/."$file" "$HOME"/."${file}"_backup
    rm -f "$HOME"/."$file"
  else
    dotfiles_info ".$file does not exist at the moment. It will be symlinked shortly."
  fi
  dotfiles_info "-> Linking $DOTFILES_DIR/git/$file to $HOME/.$file..."
  ln -nfs "$DOTFILES_DIR"/"git"/"$file" "$HOME"/."$file"
done

home_files=(
"tmux.conf"
)

for file in "${home_files[@]}"; do
  if [ -f "$HOME"/."$file" ]; then
    dotfiles_info ".$file already present. Backing up..."
    cp "$HOME"/."$file" "$HOME"/."${file}"_backup
    rm -f "$HOME"/."$file"
  else
    dotfiles_info ".$file does not exist at the moment. It will be symlinked shortly."
  fi
  dotfiles_info "-> Linking $DOTFILES_DIR/$file to $HOME/.$file..."
  ln -nfs "$DOTFILES_DIR"/"$file" "$HOME"/."$file"
done

vim_files=(
"vimrc"
)

for file in "${vim_files[@]}"; do
  if [ -f "$HOME"/."$file" ]; then
    dotfiles_info ".$file already present. Backing up..."
    cp "$HOME"/."$file" "$HOME"/."${file}"_backup
    rm -f "$HOME"/."$file"
  else
    dotfiles_info ".$file does not exist at the moment. It will be symlinked shortly."
  fi
  dotfiles_info "-> Linking $DOTFILES_DIR/vim/$file to $HOME/.$file..."
  ln -nfs "$DOTFILES_DIR"/"vim"/"$file" "$HOME"/."$file"
done

zsh_files=(
"zshrc"
)

for file in "${zsh_files[@]}"; do
  if [ -f "$HOME"/."$file" ]; then
    dotfiles_info ".$file already present. Backing up..."
    cp "$HOME"/."$file" "$HOME"/."${file}"_backup
    rm -f "$HOME"/."$file"
  else
    dotfiles_info ".$file does not exist at the moment. It will be symlinked shortly."
  fi
  dotfiles_info "-> Linking $DOTFILES_DIR/zsh/$file to $HOME/.$file..."
  ln -nfs "$DOTFILES_DIR"/"zsh"/"$file" "$HOME"/."$file"
done

mac_files=(
"Brewfile"
)

for file in "${mac_files[@]}"; do
  if [ -f "$HOME"/."$file" ]; then
    dotfiles_info ".$file already present. Backing up..."
    cp "$HOME"/."$file" "$HOME"/."${file}"_backup
    rm -f "$HOME"/."$file"
  else
    dotfiles_info ".$file does not exist at the moment. It will be symlinked shortly."
  fi
  dotfiles_info "-> Linking $DOTFILES_DIR/mac/$file to $HOME/.$file..."
  ln -nfs "$DOTFILES_DIR"/"mac"/"$file" "$HOME"/."$file"
done

python_files=(
"matplotlibrc"
)

for file in "${python_files[@]}"; do
  if [ -f "$HOME"/."$file" ]; then
    dotfiles_info ".$file already present. Backing up..."
    cp "$HOME"/."$file" "$HOME"/."${file}"_backup
    rm -f "$HOME"/."$file"
  else
    dotfiles_info ".$file does not exist at the moment. It will be symlinked shortly."
  fi
  dotfiles_info "-> Linking $DOTFILES_DIR/python/$file to $HOME/.matplotlib/$file..."
  ln -nfs "$DOTFILES_DIR"/"python"/"$file" "$HOME"/"matplotlib"/"$file"
done


##################################
# Installing Tmux plugin manager #
##################################
dotfiles_echo "Installing tmux plugin manager."
if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
  ~/.tmux/plugins/tpm/scripts/install_plugins.sh
fi


###################################################
# Installing Anaconda distribution - Python 3.7.3 #
###################################################
wget https://repo.continuum.io/archive/Anaconda3-2019.03-MacOSX-x86_64.sh
bash Anaconda3-2019.03-MacOSX-x86_64.sh -b -p ~/anaconda3
rm Anaconda3-2019.03-MacOSX-x86_64.sh


##########################
# Switching to Zsh shell #
##########################
dotfiles_echo "Switching shell to zsh. You may need to logout."
sudo sh -c "echo $(which zsh) >> /etc/shells"
chsh -s $(which zsh)


##############
# Finished! #
#############
dotfiles_echo "Dotfiles installation complete!"


dotfiles_echo "Post-install recommendations:"
dotfiles_info "The first time you launch Vim, Vim-Plug will be installed. Run :PlugInstall to install plugins, then relaunch Vim."
dotfiles_info "Remember to set your iTerm profile."
dotfiles_info "If you wish to act on OS defaults, customise and run ~/dotfiles/macos_defaults.sh"
dotfiles_info "You should log out for some changes to take effect or run 'reload!'."
dotfiles_echo "Enjoy your new home!"

exit 0
