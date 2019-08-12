DOTFILES_DIR := $(shell pwd)
UNAME := $(shell uname -s)


ifeq ($(UNAME), Darwin)
	OS := macos
else ifeq ($(UNAME), Linux)
	OS := linux
endif


all: install

install: $(OS)

.PHONY: help usage
.SILENT: help usage

help: usage

usage:
	printf "\\n\
	\\033[1mDOTFILES\\033[0m\\n\
	  $(OS)        Settings installation script.\\n\
	  make         Install all configurations and applications.\\n\
	  make link    Create symbolic links to the zsh configuration files.\\n\
	  make unlink  Remove symbolic links created by \`make link\`.\\n\
	"


.PHONY: linux macos link unlink

linux:

macos:
	xcode-select --install
	softwareupdate -ai
	anaconda
	brew
	omz
	spaceship
	link
	tmux
	zsh

link:
	ln -nfs ${DOTFILES_DIR}/tmux.conf $(HOME)/.tmux.conf
	ln -nfs ${DOTFILES_DIR}/zsh/zshrc $(HOME)/.zshrc
	ln -nfs ${DOTFILES_DIR}/git/gitconfig $(HOME)/.gitconfig
	ln -nfs ${DOTFILES_DIR}/git/gitignore_global $(HOME)/.gitignore_global
	ln -nfs ${DOTFILES_DIR}/python/matplotlibrc $(HOME)/.matplotlib/matplotlibrc
	ln -nfs ${DOTFILES_DIR}/vim/vimrc $(HOME)/.vimrc
	ln -nfs ${DOTFILES_DIR}/macos/Brewfile $(HOME)/.Brewfile

unlink:
	unlink $(HOME)/.tmux.conf
	unlink $(HOME)/.zshrc
	unlink $(HOME)/.gitconfig
	unlink $(HOME)/.gitignore_global
	unlink $(HOME)/.matplotlib/matplotlibrc
	unlink $(HOME)/.vimrc
	unlink $(HOME)/.Brewfile

.PHONY: anaconda brew defaults omz spaceship tmux zsh

anaconda:
	wget https://repo.continuum.io/archive/Anaconda3-2019.03-MacOSX-x86_64.sh
	bash Anaconda3-2019.03-MacOSX-x86_64.sh -b -p ~/anaconda3
	rm Anaconda3-2019.03-MacOSX-x86_64.sh

brew:
	if [ -f "/usr/local/bin/brew"]; then
	  echo "Homebrew is installed."
	else
	  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
	brew analytics off
	brew bundle $(DOTFILES_DIR)/macos/Brewfile
	gem install colorls

defaults:
	bash $(DOTFILES_DIR)/macos/defaults.sh

omz:
	if [ ! -d "$(HOME)/.oh-my-zsh" ]; then
	  sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install    .sh)"
	fi

spaceship:
	git clone https://github.com/denysdovhan/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt"
	ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-t    heme"

tmux:
	if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
	  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
	  ~/.tmux/plugins/tpm/scripts/install_plugins.sh
	fi

zsh:
	sudo sh -c "echo $(which zsh) >> /etc/shells"
	chsh -s $(which zsh)
