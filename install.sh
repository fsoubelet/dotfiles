#!/usr/bin/env bash

################################################################################
# Install
#
# This script symlinks dotfiles into the home directory.
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


set -e # Terminate script if anything exits with a non-zero value


###################
# Useful aliases #
##################
DOTFILES_DIR=$HOME/dotfiles
VIM_DIR=$HOME/.vim
NVIM_DIR=$HOME/.config/nvim
NVIM_CONFIG_DIR=$HOME/.config/nvim/config


###########################################
# Check and install homebrew if necessary #
###########################################
dotfiles_echo "Checking for Homebrew installation."
brew ="/usr/local/bin/brew"
if [ -f "$brew" ]; then
  dotfiles_info "Homebrew is installed."
else
  dotfiles_info "Installing Homebrew. Homebrew requires macOS command line tools, please make sure to download Xcode first."
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi


###########################################
# Install all brew packages from Brewfile #
###########################################
dotfiles_echo "Installing system packages."
brew bundle "$DOTFILES_DIR"/"Brewfile"


#####################################
# Install python support for Neovim #
#####################################
dotfiles_echo "Installing Python Neovim client."
pip3 install neovim

dotfiles_echo "Installing vim linter (vint)."
pip install vim-vint


#################################
# Check for a clean git install #
#################################
localGit ="/usr/local/bin/git"
if ! [[ -f "$localGit" ]]; then
  dotfiles_echo "Invalid git installation. Aborting. Please intall git."
  exit 1
fi


#####################
# Install oh-my-zsh #
#####################
dotfiles_echo "Installing oh-my-zsh."
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
else
  dotfiles_info "oh-my-zsh already installed."
fi


###################
# Installing vtop #
###################
dotfiles_info "Installing vtop."
npm install -g vtop






## CHECK NOT FORGETING ANYTHING
## TAKE CARE OF PYTHON STUFF?





####################################
# Setup all dotfiles with symlinks #
####################################
home_files=(
"default-gems"
"default-npm-packages"
"config/nvim"
"gitconfig"
"gitignore_global"
"tmux.conf"
"vimrc"
"zshrc"
)

dotfiles_echo "Installing dotfiles..."
dotfiles_echo "Creating backup for existing files."

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


dotfiles_info "-> Linking $DOTFILES_DIR/Brewfile to $HOME/Brewfile..."
ln -nfs "$DOTFILES_DIR"/Brewfile "$HOME"/Brewfile


####################################
# Take care of Neovim config files #
####################################
dotfiles_echo "Setting up Vim and Neovim..."

# Make sure $HOME/.config exists
if [ ! -d $HOME/.config ]; then
  dotfiles_info "Creating ~/.config"
  mkdir -p $HOME/.config
fi

# Symlink $HOME/dotfiles/config/nvim files into $HOME/.config/nvim
for config in $DOTFILES_DIR/config/*; do
  target=$HOME/.config/$( basename $config )
  if [ -e $target ]; then
    dotfiles_info " ~${target#$HOME} already exists. Removing and creating symlink."
    rm -f $target
  else
    dotfiles_info "Creating symlink for ${config}."
  fi
  ln -s $config $target
done


#############################
# Installing Neovim plugins #
#############################
dotfiles_echo "Installing the vim-plug Neovim plugin manager."
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

dotfiles_echo "Installing Neovim plugins."
nvim +PlugInstall +qall
nvim +UpdateRemotePlugins +qall

dotfiles_echo "Installing Space vim-airline theme."
cp "$DOTFILES_DIR"/nvim/space.vim ./config/vnim/plugged/vim-airline-themes/autoload/airline/themes/space.vim

dotfiles_echo "Installing tmux plugin manager"
if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
  ~/.tmux.plugins/tpm/scripts/install_plugins.sh
fi


##################################
# Installing Tmux plugin manager #
##################################
dotfiles_echo "Installing tmux plugin manager."
if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
  ~/.tmux/plugins/tpm/scripts/install_plugins.sh
fi


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
dotfiles_echo "The first time you launch Vim or Neovim, plugins will be installed."
dotfiles_echo "After launching Neovim, run :checkhealth and resolve any errors/warnings."

exit 0
