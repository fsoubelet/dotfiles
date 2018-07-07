########################################################################
# Set personal aliases, overriding those provided by oh-my-zsh libs,   #
# plugins, and themes. Aliases can be placed here, though oh-my-zsh    #
# users are encouraged to define aliases within the ZSH_CUSTOM folder. #
# For a full list of active aliases, run `alias`.                      #
#                                                                      #
# Example aliases:                                                     #
# alias ohmyzsh="mate ~/.oh-my-zsh"                                    #
########################################################################


# -------------------------------------------------------------------
# General UNIX
# -------------------------------------------------------------------
alias cclear='clear && archey && ls'
alias cdclear='cd && clear && archey && ls'
alias cp='cp -iv'
alias df='df -h'
alias ls='colorls'
alias lsg='colols --git-status . --tree'
alias lsa='colorls -lA --sf'
alias mkdir='mkdir -pv'
alias mv='mv -iv'
alias path='echo -e ${PATH//:/\\n}'
alias src='. ~/.zshrc'

# Moving around
alias .2='cd ../../'
alias .3='cd ../../../'
alias .4='cd ../../../../'
alias .5='cd ../../../../..'


# -------------------------------------------------------------------
# Global applications aliases
# -------------------------------------------------------------------
alias chatty="open -a Chatty.app"
alias code="open -a 'Xcode.app'"
alias runner="open -a 'Coderunner.app'"
alias subl="open -a 'Sublime Text.app'"
alias tex="open -a 'TeXnicle.app'"
alias zshconfig="open -a 'Atom.app' ~/.zshrc"

# Vim/Neovim
alias vi='nvim'
alias nv='nvim'


# -------------------------------------------------------------------
# Git aliases
# -------------------------------------------------------------------
alias ga='git add'
alias gaa='git add --all'
alias gb='git branch'
alias gba='git branch --all'
alias gcl='git clone'
alias gcm='git commit -mv'
alias gco='git checkout'
alias gcom='git checkout master'
alias gd='git diff'
alias gdf='git diff --word-diff --color-words'
alias gf='git fetch'
alias gl='git log --date=format:"%b %d, %Y" --pretty=format:"%C(yellow bold)%h%Creset%C(white)%d%Creset %s%n %C(blue)%aN (%cd)%n"'
alias glg='git log --graph --stat --pretty=format:"%C(yellow bold)%h%Creset%C(white)%d%Creset %s%n %C(blue)%aN (%cd)%n"'
alias gpl='git pull'
alias gps='git push'
alias gra='git remote add'
alias grr='git remote rm'
alias gs='git status'
alias gta='git tag -am'


# -------------------------------------------------------------------
# Homebrew
# -------------------------------------------------------------------
alias bc='brew cleanup'
alias bd='brew doctor'
alias bg='brew upgrade --all'
alias bp='brew prune'
alias bo='brew outdated'
alias bu='brew update'
alias bubc='brew upgrade && brew cleanup && brew cask cleanup'
alias bubo='brew update && brew outdated'
alias brewup='bubo && bubc && bd'


# -------------------------------------------------------------------
# Miscellaneous
# -------------------------------------------------------------------

# SSH CERN alias
alias sshcern='ssh -X fsoubele@lxplus.cern.ch'

# oh-my-zsh
alias upz='upgrade_oh_my_zsh'

# Easier notebook alias
alias note='jupyter notebook'

# Wifi cli utility alias (options are on and off)
alias wifi='osx-wifi-cli'

# Cleaner PATH output command
alias path='echo -e ${PATH//:/\\n}'
