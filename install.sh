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


set -e # Terminate script if anything exits with a non-zero value


###################
# Useful aliases #
##################
DOTFILES_DIR=$HOME/dotfiles
VIM_DIR=$HOME/.vim
NVIM_DIR=$HOME/.config/nvim
NVIM_CONFIG_DIR=$HOME/.config/nvim/config


######################################################
# I homebrew if necessary and then homebrew packages #
######################################################
dotfiles_echo "Checking for Homebrew installation."
brew ="/usr/local/bin/brew"
if [ -f "$brew" ]; then
  dotfiles_info "Homebrew is installed."
else
  dotfiles_info "Installing Homebrew. Homebrew requires macOS command line tools, please make sure to download Xcode first."
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

dotfiles_echo "Installing system packages."
brew bundle "$DOTFILES_DIR"/"Brewfile"


#####################################
# Install python support for Neovim #
#####################################
dotfiles_echo "Installing Python Neovim client."
pip install neovim

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


###################
# Installing vtop #
###################
dotfiles_info "Installing vtop."
npm install -g vtop


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


#################################################
# Setting up useful python packages as well as  #
#################################################

# It is recommended to install the anaconda python distribution first.

# Install pip packages
#pip install -r pip_requirements.txt

# Create a conda python 3.6 environment named py36
#conda create -n py36 python=3.6 anaconda
#source activate py36

# Make python3 kernel also available for jupyter (python2 is by default)
#pip3 install jupyter
#jupyter kernelspec install python3
#source deactivate py36


####################################
# Setup all dotfiles with symlinks #
####################################
home_files=(
"default-gems"
"default-npm-packages"
"gitconfig"
"gitignore_global"
"tmux.conf"
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

# Matplotlibrc config file
if [ -f "$HOME"/".matplotlibrc/matplotlibrc" ]; then
  dotfiles_info "$HOME/.matplotlibrc/matplotlibrc already present. Backing up..."
  cp "$HOME"/.matplotlibrc/matplotlibrc "$HOME"/.matplotlibrc/matplotlibrc_backup
  rm -f "$HOME"/.matplotlibrc/matplotlibrc
else
  dotfiles_info "$HOME/.matplotlibrc/matplotlibrc does not exist at the moment. It will be symlinked shortly."
fi
dotfiles_info "-> Linking $DOTFILES_DIR/matplotlibrc to $HOME/.matplotlibrc/matplotlibrc..."
ln -nfs "$DOTFILES_DIR"/matplotlibrc "$HOME"/.matplotlibrc/matplotlibrc

# Atom packages file
if [ -f "$HOME"/".atom/packages.cson" ]; then
  dotfiles_info "$HOME/.atom/packages.cson already present. Backing up..."
  cp "$HOME"/.atom/packages.cson "$HOME"/.atom/packages.cson_backup
  rf -f "$HOME"/.atom/packages.cson
else
  dotfiles_info "$HOME/.atom/packages.cson does not exist at the moment. It will be symlinked shortly."
fi
dotfiles_info "-> Linking $DOTFILES_DIR/atom/packages.cson to $HOME/.atom/packages.cson..."
ln -nfs "$DOTFILES_DIR"/atom/packages.cson "$HOME"/.atom/packages.cson


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
dotfiles_info "The first time you launch Vim or Neovim, plugins will be installed."
dotfiles_info "After launching Neovim, run :checkhealth and resolve any errors/warnings."
dotfiles_info "Remember to set you iTerm profile as well as Atom themes."
dotfiles_info "If you wish to act on OS defaults, customise and run ~/dotfiles/macos_defaults.sh"
dotfiles_echo "You should log out for some changes to take effect."

exit 0
