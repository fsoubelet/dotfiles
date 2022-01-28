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

.PHONY: help mambaforge brew defaults link linux macos omz unlink zsh

help:
	@echo "Dotfiles Makefile. Please use 'make $(R)<target>$(E)' where $(R)<target>$(E) is one of:"
	@echo "  $(R) $(OS) $(E)        to run all installation steps."
	@echo "  $(R) link $(E)         to create symbolic links for configuration files."
	@echo "  $(R) unlink $(E)       to remove symbolic links created by 'make link'."
	@echo "  $(R) brew $(E)         to install Homebrew if not present already, and install packages listed in the Brewfile."
	@echo "  $(R) defaults $(E)     to change macos defaults as specified in 'macos/macos_defaults.sh'."
	@echo "  $(R) mambaforge $(E)   to install the latest Mambaforge distribution."
	@echo "  $(R) omz $(E)          to install oh-my-zsh and required plugin files if not present already."
	@echo "  $(R) unlink $(E)       to remove symlink to configuration files."
	@echo "  $(R) zsh $(E)          to switch to the Z shell."

linux:
	@echo "This is not yet implemented."

macos:
	@echo "Installing Xcode command-line tools."
	@xcode-select --install
	@softwareupdate -ai
	@make brew
	@make mambaforge
	@make zsh
	@make omz
	@make link

mambaforge:
	@echo "$(B)Downloading native Mambaforge distribution.$(E)"
	@curl -L -O "https://github.com/conda-forge/miniforge/releases/latest/download/Mambaforge-$(uname)-$(uname -m).sh"
	@echo "$(B)Installing Mambaforge distribution.$(E)"
	@bash Mambaforge-$(uname)-$(uname -m).sh -b  # batch install mode (no confirm), defaults to ~/mambaforge
	@echo "$(B)Removing installer from disk.$(E)"
	@rm -rf Mambaforge-$(uname)-$(uname -m).sh

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
	@mkdir -p $(HOME)/.config/nvim
	@ln -nfs ${DOTFILES_DIR}/vim/init.vim $(HOME)/.config/nvim/init.vim
	@echo "Linking Brewfile to home folder."
	@ln -nfs ${DOTFILES_DIR}/macos/Brewfile $(HOME)/.Brewfile
	@echo "Linking SSH config file."
	@ln -nfs ${DOTFILES_DIR}/configs/ssh_config $(HOME)/.ssh/config
	@echo "Linking configuration files."
	@ln -nfs ${DOTFILES_DIR}/configs/bat_config $(shell bat --config-file)
	@ln -nfs ${DOTFILES_DIR}/configs/htoprc $(HOME)/.config/htop/htoprc
	@ln -nfs ${DOTFILES_DIR}/configs/starship.toml $(HOME)/.config/starship.toml

omz:
	@echo "$(B)Checking valid oh-my-zsh installation.$(E)"
	@bash ${DOTFILES_DIR}/zsh/omz_install.sh
	@echo "$(B)Installing required plugins.$(E)"
	@bash ${DOTFILES_DIR}/zsh/omz_plugins.sh

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
