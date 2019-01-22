# Path to oh-my-zsh installation
export ZSH=$HOME/.oh-my-zsh
export UPDATE_ZSH_DAYS=7

# Setting prompt appearance
ZSH_THEME="oxide"
#ZSH_THEME="hyperzsh"
#ZSH_THEME="spaceship"


# Enable flags completion // file seems to be missing
#source $(dirname $(which colorls))/tab_complete.sh

DISABLE_AUTO_TITLE="true"
COMPLETION_WAITING_DOTS="true"
ENABLE_CORRECTION="true"

HISTFILE= ~/.zsh_history
HIST_STAMPS="dd-mm-yyyy"
HISTSIZE=5000
SAVEHIST=5000
#setopt APPEND_HISTORY                       # Allow multiple terminal sessions to all append to one zsh
#setopt HIST_EXPIRE_DUPS_FIRST               # When duplicates are entered, get rid of the duplicates first when we hit $HISTSIZE


# Getting some colors into the ls output
export LS_COLORS='di=1;94:ln=94:so=32:pi=33:ex=32:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30:*.py=34:*.madx=33:*.seq=33:*.png=95:*.sh=1;33:*.md=1;37:*.pdf=31:'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}


plugins=(fast-syntax-highlighting you-should-use zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh
