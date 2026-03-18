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

.PHONY: help brew cargo defaults link linux macos miniforge omz unlink

help:
	@echo "Dotfiles Makefile. Please use 'make $(R)<target>$(E)' where $(R)<target>$(E) is one of:"
	@echo "  $(R) $(OS) $(E)        to run all installation steps."
	@echo "  $(R) link $(E)         to create symbolic links for configuration files."
	@echo "  $(R) unlink $(E)       to remove symbolic links created by 'make link'."
	@echo "  $(R) brew $(E)         to install Homebrew if not present already, and install packages listed in the Brewfile."
	@echo "  $(R) defaults $(E)     to change macos defaults as specified in 'macos/macos_defaults.sh'."
	@echo "  $(R) miniforge $(E)    to install the latest miniforge distribution."
	@echo "  $(R) omz $(E)          to install oh-my-zsh and required plugin files if not present already."

linux:
	@echo "This is not yet implemented."

macos:
	@echo "Ensuring Xcode command-line tools."
	@xcode-select -p &>/dev/null || (echo "Installing Xcode command-line tools." && xcode-select --install)
	@softwareupdate -ai
	@make cargo
	@make brew
	@make miniforge
	@make omz
	@make link

brew:
	# Each command target is its own shell so to have printfuncs persist we chain
	@source ${DOTFILES_DIR}/zsh/printfuncs.sh && source ${DOTFILES_DIR}/macos/homebrew_install.sh
	@brew analytics off
	@echo "$(B)Installing Homebrew packages from Brewfile.$(E)"
	@cd $(DOTFILES_DIR)/macos; PATH="$$HOME/.cargo/bin:$$PATH"; brew bundle; cd $(DOTFILES_DIR)
	@rm -rf $(DOTFILES_DIR)/macos/Brewfile.lock.json

cargo:
	@echo "$(B)Installing Rust and Cargo.$(E)"
	@curl https://sh.rustup.rs -sSf | sh

defaults:
	@echo "Changing some macos defaults according to configuration file."
	@echo "Make sure you customize this file to your needs.$(E)."
	@bash $(DOTFILES_DIR)/macos/macos_defaults.sh

link:  # the -p in mkdir commands is idempotent
	@echo "Linking .zshrc to home folder."
	@ln -nfs ${DOTFILES_DIR}/zsh/zshrc $(HOME)/.zshrc
	@echo "Linking SSH config file."
	@mkdir -p ~/.ssh/
	@ln -nfs ${DOTFILES_DIR}/configs/ssh_config $(HOME)/.ssh/config
	@echo "Linking git configuration files."
	@mkdir -p $(HOME)/.config/git
	@ln -nfs $(DOTFILES_DIR)/configs/gitconfig $(HOME)/.config/git/config
	@ln -nfs $(DOTFILES_DIR)/configs/gitignore_global $(HOME)/.config/git/ignore
	@echo "Linking other configuration files."
	@mkdir -p ~/.config/bat/
	@ln -nfs ${DOTFILES_DIR}/configs/bat_config $(shell bat --config-file)
	@mkdir -p $(HOME)/.config/htop
	@ln -nfs ${DOTFILES_DIR}/configs/htoprc $(HOME)/.config/htop/htoprc
	@ln -nfs ${DOTFILES_DIR}/configs/starship.toml $(HOME)/.config/starship.toml
	@mkdir -p $(HOME)/.config/conda
	@ln -nfs ${DOTFILES_DIR}/configs/condarc $(HOME)/.config/conda/condarc
	@mkdir -p $(HOME)/.config/marimo
	@ln -nfs ${DOTFILES_DIR}/configs/marimo.toml $(HOME)/.config/marimo/marimo.toml

miniforge:
	@echo "$(B)Downloading native miniforge distribution.$(E)"
	@curl -L -O "https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-$(UNAME)-$(shell uname -m).sh"
	@echo "$(B)Installing miniforge distribution.$(E)"
	@bash Miniforge3-$(UNAME)-$(shell uname -m).sh -b -p $(HOME)/.miniforge # batch install mode, specify prefix
	@echo "$(B)Removing installer from disk.$(E)"
	@rm -f Miniforge3-$(UNAME)-$(shell uname -m).sh

omz:
	# Each command target is its own shell so to have printfuncs persist we chain
	@source ${DOTFILES_DIR}/zsh/printfuncs.sh && source ${DOTFILES_DIR}/zsh/omz_install.sh

unlink:
	@echo "$(B)Removing symlinks.$(E)"
	@unlink $(HOME)/.zshrc
	@unlink $(HOME)/.ssh/config
	@unlink $(HOME)/.config/git/config
	@unlink $(HOME)/.config/git/ignore
	@unlink $(HOME)/.config/bat/config
	@unlink $(HOME)/.config/htop/htoprc
	@unlink $(HOME)/.config/starship.toml
	@unlink $(HOME)/.config/conda/condarc
	@unlink $(HOME)/.config/marimo/marimo.toml
