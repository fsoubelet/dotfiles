export ZSH = $HOME/.oh-my-zsh
export UPDATE_ZSH_DAYS = 7


ZSH_THEME = "powerlevel9k/powerlevel9k"

POWERLEVEL9K_SHORTEN_DIR_LENGTH = 2
POWERLEVEL9K_SHORTEN_DIR_STRATEGY = "truncate_middle"

POWERLEVEL9K_LEFT_PROMPT_ELEMENTS = (os_icon dir vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS = (status root_indicator ssh background_jobs history)

DISABLE_AUTO_TITLE="true"
COMPLETION_WAITING_DOTS="true"

HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history
HIST_STAMPS="dd-mm-yyyy"

plugins = (git colorize osx python sudo fast_syntax_highlighting history shrink_path)

source $ZSH/oh-my-zsh.sh
