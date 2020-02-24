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

BAT_CONFIG := $(shell bat --config-file)
DOTFILES_DIR := $(shell pwd)
UNAME := $(shell uname -s)


ifeq ($(UNAME), Darwin)
	OS := macos
else ifeq ($(UNAME), Linux)
	OS := linux
endif


all: install

install: $(OS)

.PHONY: help anaconda brew defaults link linux macos omz plugins unlink zsh

help:
	@echo "Dotfiles Makefile. Please use 'make $(R)<target>$(E)' where $(R)<target>$(E) is one of:"
	@echo "  $(R) $(OS) $(E)        to run the settings installation script."
	@echo "  $(R) link $(E)         to create symbolic links for configuration files."
	@echo "  $(R) unlink $(E)       to remove symbolic links created by 'make link'."
	@echo "  $(R) anaconda $(E)     to install an Anaconda distribution, with Python 3. Currently this installs '2019.10'."
	@echo "  $(R) brew $(E)         to install Homebrew if not present already, and install packages listed in the Brewfile."
	@echo "  $(R) defaults $(E)     to change macos defaults as specified in 'macos/macos_defaults.sh'."
	@echo "  $(R) omz $(E)          to install oh-my-zsh if not present already."
	@echo "  $(R) plugins $(E)      to locally install the required files for oh-my-zsh plugins."
	@echo "  $(R) zsh $(E)          to switch to the Z shell."

linux:
	@echo "This is not yet implemented."

macos:
	@echo "Installing Xcode command-line tools."
	@xcode-select --install
	@softwareupdate -ai
	@make brew
	@make anaconda
	@make zsh
	@make oh_my_zsh
	@make plugins
	@make link

anaconda:
	@echo "$(B)Downloading Anaconda distribution.$(E)"
	@wget https://repo.anaconda.com/archive/Anaconda3-2019.10-MacOSX-x86_64.sh
	@echo "$(B)Installing Anaconda distribution.$(E)"
	@bash Anaconda3-2019.03-MacOSX-x86_64.sh -b -p ~/anaconda3
	@echo "$(B)Removing installer from disk.$(E)"
	@rm -rf Anaconda3-2019.03-MacOSX-x86_64.sh

brew:
	@echo "$(B)Checking valid Homebrew installation.$(E)"
	@bash ${DOTFILES_DIR}/macos/homebrew_install.sh
	@brew analytics off
	@echo "$(B)Installing Homebrew packages from Brewfile.$(E)"
	@cd $(DOTFILES_DIR)/macos; brew bundle; cd $(DOTFILES_DIR)
	@rm -rf $(DOTFILES_DIR)/macos/Brewfile.lock.json
	@sudo gem install colorls

defaults:
	@echo "Changing some macos defaults according to configuration file."
	@echo "Make sure you customize this file to your needs.$(E)."
	@bash $(DOTFILES_DIR)/macos/defaults.sh

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
	@echo "Linking SSH config file."
	@ln -nfs ${DOTFILES_DIR}/configs/ssh_config $(HOME)/.ssh/config
	@echo "Linking configuration files."
	@ln -nfs ${DOTFILES_DIR}/configs/bat_config $(shell bat --config-file)

omz:
	@echo "$(B)Checking valid oh-my-zsh installation.$(E)"
	@bash ${DOTFILES_DIR}/zsh/omz_install.sh

plugins: omz
	@echo "$(B)Cloning 'fast-syntax-highlighting' files to local plugins directory.$(E)"
	@git clone https://github.com/zdharma/fast-syntax-highlighting.git "$ZSH_CUSTOM/plugins/fast-syntax-highlighting"
	@echo "$(B)Cloning 'you-should-use' files to local plugins directory.$(E)"
	@git clone https://github.com/MichaelAquilina/zsh-you-should-use.git "$ZSH_CUSTOM/plugins/you-should-use"
	@echo "$(B)Cloning 'zsh-autosuggestions' files to local plugins directory.$(E)"
	@git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
	@echo "$(B)Cloning files for Spaceship prompt.$(E)"
	@git clone https://github.com/denysdovhan/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt"
	@ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"

unlink:
	@echo "$(B)Removing symlinks.$(E)"
	@unlink $(HOME)/.tmux.conf
	@unlink $(HOME)/.zshrc
	@unlink $(HOME)/.gitconfig
	@unlink $(HOME)/.gitignore_global
	@unlink $(HOME)/.vimrc
	@unlink $(HOME)/.Brewfile
	@unlink $(HOME)/.ssh/config
	@unlink $(HOME)/.config/bat/config

zsh:
	@echo "$(B)Switching to the Z shell.$(E)"
	@sudo sh -c "echo $(which zsh) >> /etc/shells"
	@chsh -s $(which zsh)