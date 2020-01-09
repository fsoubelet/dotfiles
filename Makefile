# Copyright 2019-2020 Felix Soubelet <felix.soubelet@cern.ch>
# MIT License

# Documentation for most of what you will see here can be found at the following links:
# for the GNU make special targets: https://www.gnu.org/software/make/manual/html_node/Special-Targets.html

# ANSI escape sequences for bold, cyan, dark blue, end, pink and red.
B = \033[1m
C = \033[96m
D = \033[34m
E = \033[0m
P = \033[95m
R = \033[31m

DOTFILES_DIR := $(shell pwd)
UNAME := $(shell uname -s)


ifeq ($(UNAME), Darwin)
	OS := macos
else ifeq ($(UNAME), Linux)
	OS := linux
endif


all: install

install: $(OS)

.PHONY: help anaconda brew defaults link linux macos omz spaceship tmux unlink zsh

help:
	@echo "Dotfiles Makefile. Please use 'make $(R)<target>$(E)' where $(R)<target>$(E) is one of:"
	@echo "  $(R) $(OS) $(E)        to run the settings installation script."
	@echo "  $(R) link $(E)         to create symbolic links for configuration files."
	@echo "  $(R) unlink $(E)       to remove symbolic links created by 'make link'."
	@echo "  $(R) anaconda $(E)     to install an Anaconda distribution, with Python 3. Currently this installs '2019.10'."
	@echo "  $(R) brew $(E)         to install Homebrew if not present already, and install packages listed in the Brewfile."
	@echo "  $(R) defaults $(E)     to change macos defaults as specified in 'macos/macos_defaults.sh'."
	@echo "  $(R) oh_my_zsh $(E)    to install oh-my-zsh if not present already."
	@echo "  $(R) spaceship $(E)    to locally install the required files for the spaceship prompt for zsh."
	@echo "  $(R) tmux $(E)         to install tmux if not present already."
	@echo "  $(R) zsh $(E)          to switch to the zsh shell."

linux:
	@echo "This is not yet implemented."

macos:
	@echo "Installing Xcode command-line tools."
	@xcode-select --install
	@softwareupdate -ai
	@make anaconda
	@make brew
	@make oh_my_zsh
	@make plugins
	@make spaceship
	@make link
	@make tmux
	@make zsh

link:
	@echo "Linking tmux configuration file to home folder."
	@ln -nfs ${DOTFILES_DIR}/tmux.conf $(HOME)/.tmux.conf
	@echo "Linking .zshrc to home folder."
	@ln -nfs ${DOTFILES_DIR}/zsh/zshrc $(HOME)/.zshrc
	@echo "Linking git configuration files to home folder."
	@ln -nfs ${DOTFILES_DIR}/git/gitconfig $(HOME)/.gitconfig
	@ln -nfs ${DOTFILES_DIR}/git/gitignore_global $(HOME)/.gitignore_global
	@echo "Linking .vimrc to home folder."
	@ln -nfs ${DOTFILES_DIR}/vim/vimrc $(HOME)/.vimrc
	@echo "Linking Brewfile to home folder."
	@ln -nfs ${DOTFILES_DIR}/macos/Brewfile $(HOME)/.Brewfile

unlink:
	@echo "Removing symlinks."
	@unlink $(HOME)/.tmux.conf
	@unlink $(HOME)/.zshrc
	@unlink $(HOME)/.gitconfig
	@unlink $(HOME)/.gitignore_global
	@unlink $(HOME)/.vimrc
	@unlink $(HOME)/.Brewfile

anaconda:
	@echo "Downloading Anaconda distribution."
	@wget https://repo.anaconda.com/archive/Anaconda3-2019.10-MacOSX-x86_64.sh
	@echo "Installing Anaconda distribution."
	@bash Anaconda3-2019.03-MacOSX-x86_64.sh -b -p ~/anaconda3
	@echo "Removing installer from disk."
	@rm -rf Anaconda3-2019.03-MacOSX-x86_64.sh

brew:
	@echo "Checking valid Homebrew installation."
	@if [ -f "/usr/local/bin/brew"]; then\
	  @echo "Good news: Homebrew is installed."\
	@else\
	  @echo "No installation found. Downloading and installing Homebrew." \
	  @/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" \
	@brew analytics off \
	@echo "Installing Homebrew packages from Brewfile." \
	@brew bundle $(DOTFILES_DIR)/macos/Brewfile \
	@gem install colorls \

defaults:
	@echo "Changing some macos defaults according to the
	@bash $(DOTFILES_DIR)/macos/defaults.sh

oh_my_zsh:
	@echo "Checking valid oh-my-zsh installation."
	@if [ ! -d "$(HOME)/.oh-my-zsh" ]
	then
		@echo "No installation found. Downloading and installing oh-my-zsh."
		@sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
	@fi

plugins:
	@echo "Cloning 'fast-syntax-highlighting' files to local plugins directory."
	@git clone https://github.com/zdharma/fast-syntax-highlighting.git $ZSH_CUSTOM/plugins/fast-syntax-highlighting
	@echo "Cloning 'you-should-use' files to local plugins directory."
	@git clone https://github.com/MichaelAquilina/zsh-you-should-use.git $ZSH_CUSTOM/plugins/you-should-use
	@echo "Cloning 'zsh-autosuggestions' files to local plugins directory."
	@git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions

spaceship:
	@echo "Cloning files for Spaceship prompt."
	@git clone https://github.com/denysdovhan/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt"
	@ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"

tmux:
	@echo "Installing tmux plugin manager."
	@if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
	  @git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
	  @~/.tmux/plugins/tpm/scripts/install_plugins.sh
	@fi

zsh:
	@echo "Switching to zsh shell."
	@sudo sh -c "echo $(which zsh) >> /etc/shells"
	@chsh -s $(which zsh)