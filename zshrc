# ~/.zshrc

export TERM="xterm-256color"
export ZSH=$HOME/.oh-my-zsh
export PATH=$HOME/bin:/usr/local/sbin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin
#export EDITOR="nvim"
#export MANPAGER='less -X' # Don’t clear the screen after quitting a manual page
export LESS_TERMCAP_md="${yellow}" # Highlight section titles in manual pages
eval "$(dircolors -b)"


# All shell customization
source $HOME/dotfiles/zsh/oh_my_zsh_settings.sh
source $HOME/dotfiles/zsh/aliases.sh
source $HOME/dotfiles/zsh/functions.sh
#source $HOME/dotfiles/zsh/tmux.sh


# Adding lxplus madx to PATH
export PATH="$PATH:/afs/cern.ch/user/m/mad/bin"

# Added by Anaconda3 installer
 export PATH="/afs/cern.ch/work/f/fesoubel/anaconda3/bin:$PATH"

# Getting Poetry tool in the PATH
export PATH="$PATH:$HOME/.poetry/bin"
