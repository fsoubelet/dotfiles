# Path to oh-my-zsh installation
export ZSH=$HOME/.oh-my-zsh
export UPDATE_ZSH_DAYS=5
export ZSH_COMPDUMP=$ZSH/cache/.zcompdump-$HOST

ZSH_THEME=""  # not set and will let Starship handle it

DISABLE_AUTO_TITLE="true"
COMPLETION_WAITING_DOTS="true"
ENABLE_CORRECTION="true"

HISTFILE=~/.cache/.zsh_history
HIST_STAMPS="yyyy-mm-dd"
HISTSIZE=5000
SAVEHIST=5000
setopt APPEND_HISTORY                       # Allow multiple terminal sessions to all append to one zsh command history
setopt HIST_EXPIRE_DUPS_FIRST               # When duplicates are entered, get rid of the duplicates first when we hit $HISTSIZE

# Enabled true color support for terminals
export NVIM_TUI_ENABLE_TRUE_COLOR=1

plugins=(colored-man-pages fast-syntax-highlighting zsh-autosuggestions)

source "${ZSH}"/oh-my-zsh.sh
