# Path to oh-my-zsh installation
export ZSH=$HOME/.oh-my-zsh
export UPDATE_ZSH_DAYS=7


ZSH_THEME="spaceship"

# Set Spaceship ZSH as a prompt
autoload -U promptinit; promptinit
prompt spaceship

# Enable flags completion
source $(dirname $(gem which colorls))/tab_complete.sh

DISABLE_AUTO_TITLE="true"
COMPLETION_WAITING_DOTS="true"

HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history
HIST_STAMPS="dd-mm-yyyy"

plugins=(git osx python sudo fast_syntax_highlighting history colorize)

source $ZSH/oh-my-zsh.sh
