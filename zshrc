# ~/.zshrc

export TERM="xterm-256color"
export ZSH=$HOME/.oh-my-zsh
export PATH=$HOME/bin:/usr/local/sbin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin
export EDITOR="nvim"
export MANPAGER='less -X' # Don’t clear the screen after quitting a manual page
export LESS_TERMCAP_md="${yellow}" # Highlight section titles in manual pages

# Making sure to not tune the homebrew sbin out of the PATH. Will be preceeded
# by Anaconda installs later in this file
export PATH="/usr/local/sbin:$PATH"

# All shell customization
source $HOME/dotfiles/zsh/oh_my_zsh_settings.sh
source $HOME/dotfiles/zsh/aliases.sh
source $HOME/dotfiles/zsh/functions.sh
source $HOME/dotfiles/zsh/tmux.sh

# Added by Anaconda3 5.3.0 installer
export PATH="/Users/felixsoubelet/anaconda3/bin:$PATH"

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

# Getting Poetry tool in the PATH
export PATH="$PATH:$HOME/.poetry/bin"
