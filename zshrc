# ~/.zshrc


export PATH=$HOME/bin:/usr/local/sbin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin
export TERM="xterm-256color"
export EDITOR="nvim"


source $HOME/dotfiles/zsh/oh_my_zsh_settings.sh
source $HOME/dotfiles/zsh/aliases.sh
source $HOME/dotfiles/zsh/functions.sh
#source $HOME/dotfiles/zsh/spaceship.sh     # To implement the spaceship prompt


# Added by Anaconda2 4.3.1 installer
export PATH="/Users/felixsoubelet/anaconda2/bin:$PATH"


# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
