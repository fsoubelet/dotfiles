#!/usr/bin/env bash

################################################################################
# install
#
# This script symlinks dotfiles into the home directory.
################################################################################


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


set -e # Terminate script if anything exits with a non-zero value


# Some useful aliases
DOTFILES_DIR=$HOME/dotfiles
VIM_DIR=$HOME/.vim
NVIM_DIR=$HOME/.config/nvim
NVIM_CONFIG_DIR=$HOME/.config/nvim/config


dotfiles_echo "Checking for Homebrew installation."
brew ="/usr/local/bin/brew"


if [ -f "$brew" ]; then
  dotfiles_info "Homebrew is installed."
else
  dotfiles_info "Installing Homebrew. Homebrew requires macOS command line tools, please download Xcode first."
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi


dotfiles_echo "Installing system packages."
brew bundle "$DOTFILES_DIR"/"Brewfile"


dotfiles_echo "Installing dotfiles..."


dotfiles_echo "Installing Python Neovim client."
pip3 install neovim

home_files=(
"default-gems"
"default-npm-packages"
"gitconfig"
"gitignore_global"
"tmux.conf"
"vimrc"
"zshrc"
)

for file in "${home_files[@]}"; do
  if [ -f "$HOME"/."$file" ]; then
    dotfiles_info ".$file already present. Backing up..."
    cp "$HOME"/."$file" "$HOME"/."${file}"_backup
    rm -f "$HOME"/."$file"
  fi
  dotfiles_info "-> Linking $DOTFILES_DIR/$file to $HOME/.$file..."
  ln -nfs "$DOTFILES_DIR"/"$file" "$HOME"/."$file"
done


dotfiles_info "-> Linking $DOTFILES_DIR/Brewfile to $HOME/Brewfile..."
ln -nfs "$DOTFILES_DIR"/Brewfile "$HOME"/Brewfile


dotfiles_echo "Setting up Vim and Neovim..."


if [ ! -d "$VIM_DIR" ]; then
  mkdir -p "$VIM_DIR"
fi


if [ ! -d "$NVIM_DIR" ]; then
  mkdir -p "$NVIM_DIR"
fi


if [ ! -d "$NVIM_CONFIG_DIR"]; then
  mkdir -p "$NVIM_CONFIG_DIR"
fi


dotfiles_info "-> Linking $DOTFILES_DIR/vim/ftplugin to $VIM_DIR/ftplugin..."
ln -nfs "$DOTFILES_DIR"/vim/ftplugin "$VIM_DIR"/ftplugin


dotfiles_info "-> Linking $DOTFILES_DIR/vim/colors to $VIM_DIR/colors..."
ln -nfs "$DOTFILES_DIR"/vim/colors "$VIM_DIR"/colors


dotfiles_info "-> Linking $DOTFILES_DIR/vim/spell to $VIM_DIR/spell..."
ln -nfs "$DOTFILES_DIR"/vim/spell "$VIM_DIR"/spell


dotfiles_info "-> Linking $DOTFILES_DIR/vim/UltiSnips to $VIM_DIR/UltiSnips..."
ln -nfs "$DOTFILES_DIR"/vim/UltiSnips "$VIM_DIR"/UltiSnips


dotfiles_info "-> Linking $DOTFILES_DIR/init.vim to $NVIM_DIR/init.vim..."
ln -nfs "$DOTFILES_DIR"/init.vim "$NVIM_DIR"/init.vim

# WORK ON THESE -> Link dotfiles/vim/config/ files
#dotfiles_echo "-> Linking $DOTFILES_DIR/vim/config/general.vimrc" to $NVIM_CONFIG_DIR/general.vimrc"
#ln -nfs "$DOTFILES_DIR/vim/config"/general.vimrc "$NVIM_CONFIG_DIR"/general.vimrc


dotfiles_echo "Dotfiles installation complete!"


dotfiles_echo "Post-install recommendations:"
dotfiles_echo "- Complete Brew Bundle installation by running 'brew bundle install'"
dotfiles_echo "- The first time you launch Vim or Neovim, plugins will be installed automatically."
dotfiles_echo "- After launching Neovim, run :checkhealth and resolve any errors/warnings."
