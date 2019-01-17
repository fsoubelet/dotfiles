# Path to oh-my-zsh installation
export ZSH=$HOME/.oh-my-zsh
export UPDATE_ZSH_DAYS=7

ZSH_THEME="spaceship"

# Set Spaceship ZSH as a prompt
#autoload -U promptinit; promptinit
#prompt spaceship

# Enable flags completion // file seems to be missing
#source $(dirname $(which colorls))/tab_complete.sh

DISABLE_AUTO_TITLE="true"
COMPLETION_WAITING_DOTS="true"
ENABLE_CORRECTION="true"

HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history
HIST_STAMPS="dd-mm-yyyy"

# Enabled true color support for terminals
export NVIM_TUI_ENABLE_TRUE_COLOR=1

plugins=(brew fast-syntax-highlighting you-should-use zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh
