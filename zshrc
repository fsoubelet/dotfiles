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

# Getting cargo in the PATH
export PATH="$PATH:$HOME/.cargo/bin"

# Getting neofetch in the PATH
export PATH="$PATH:$HOME/.neofetch/"
clear && neofetch && ls

# Source production Python environment
source /afs/cern.ch/work/f/fesoubel/public/felix_prodenv/bin/activate

# For bat to have better scrolling
export BAT_PAGER="less -RF"
