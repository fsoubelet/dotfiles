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
	@echo "  $(R) unlink $(E)       to remove symlink to configuration files."

linux:
	@echo "This is not yet implemented."

macos:
	@echo "Installing Xcode command-line tools."
	@xcode-select --install
	@softwareupdate -ai
	@make cargo
	@make brew
	@make miniforge
	@make omz
	@make link

brew:
	@source ${DOTFILES_DIR}/zsh/printfuncs.sh
	@source ${DOTFILES_DIR}/macos/homebrew_install.sh
	@brew analytics off
	@echo "$(B)Installing Homebrew packages from Brewfile.$(E)"
	@cd $(DOTFILES_DIR)/macos; brew bundle; cd $(DOTFILES_DIR)
	@rm -rf $(DOTFILES_DIR)/macos/Brewfile.lock.json
	@sudo gem install colorls

cargo:
	@echo "$(B)Installing Rust and Cargo.$(E)"
	@curl https://sh.rustup.rs -sSf | sh
	@echo "$(B)Installing relevant packages from Cargo.$(E)"
	@cargo install bat bottom difftastic dysk eza hyperfine ripgrep tealdeer uv zoxide

defaults:
	@echo "Changing some macos defaults according to configuration file."
	@echo "Make sure you customize this file to your needs.$(E)."
	@bash $(DOTFILES_DIR)/macos/defaults.sh

link:
	@echo "Linking .zshrc to home folder."
	@ln -nfs ${DOTFILES_DIR}/zsh/zshrc $(HOME)/.zshrc
	@echo "Linking zsh plugins file to home folder."
	@ln -nfs ${DOTFILES_DIR}/zsh/plugins.zsh $(HOME)/.zsh_plugins.txt
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

miniforge:
	@echo "$(B)Downloading native miniforge distribution.$(E)"
	@curl -L -O "https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-$(uname)-$(uname -m).sh"
	@echo "$(B)Installing miniforge distribution.$(E)"
	@bash Miniforge3-$(uname)-$(uname -m).sh -b -p $(HOME)/.miniforge # batch install mode, specify prefix
	@echo "$(B)Removing installer from disk.$(E)"
	@rm -rf bash Miniforge3-$(uname)-$(uname -m).sh

omz:
	@source ${DOTFILES_DIR}/zsh/printfuncs.sh
	@source ${DOTFILES_DIR}/zsh/omz_install.sh

unlink:
	@echo "$(B)Removing symlinks.$(E)"
	@unlink $(HOME)/.zshrc
	@unlink $(HOME)/.gitconfig
	@unlink $(HOME)/.gitignore_global
	@unlink $(HOME)/.vimrc
	@unlink $(HOME)/.Brewfile
	@unlink $(HOME)/.ssh/config
	@unlink $(HOME)/.config/bat/config
