# -------------------------------------------------------------------
# General UNIX
# -------------------------------------------------------------------
alias clr='clear'
alias cclr='clear && archey && ls'
alias qlr='cd && clear && archey && ls'
alias cp='cp -iv'
alias df='df -h'
alias ls='colorls'
alias lsg='colols --git-status . --tree'
alias lsa='colorls -lA --sf'
alias mkdir='mkdir -pv'
alias mv='mv -iv'
alias path='echo -e ${PATH//:/\\n}'
alias src='. ~/.zshrc'

alias fd='find . -type d -name'
alias ff='find . -type f -name'

# Moving around
alias .2='cd ../../'
alias .3='cd ../../../'
alias .4='cd ../../../../'
alias .5='cd ../../../../..'
alias dotfiles='cd ~/dotfiles'
[ -d ~/Desktop ]   && alias dt='cd ~/Desktop'
[ -d ~/Downloads ] && alias dl='cd ~/Downloads'
[ -d ~/Dropbox ]   && alias dr='cd ~/Dropbox'


# -------------------------------------------------------------------
# Global applications aliases
# -------------------------------------------------------------------
alias atom="open -a 'Atom.app'"
alias code="open -a 'Xcode.app'"
alias runner="open -a 'Coderunner.app'"
alias tex="open -a 'TeXnicle.app'"
alias zshconfig="open -a 'Atom.app' ~/dotfiles/zshrc"

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


# -------------------------------------------------------------------
# Safety first
# -------------------------------------------------------------------

_exists() {
  command -v $1 > /dev/null 2>&1
}

# Avoid stupidity with trash-cli on macOs
if _exists trash; then
  alias rm='trash'
else
  alias rm='rm -i'
fi


# -------------------------------------------------------------------
# Miscellaneous
# -------------------------------------------------------------------

# SSH CERN alias
alias sshcern='ssh -X fsoubele@lxplus.cern.ch'

# oh-my-zsh
alias upz='upgrade_oh_my_zsh'

# Easier notebook alias
alias jupy='jupyter notebook --browser=safari'

# Wifi cli utility alias (options are on and off)
alias wifi='osx-wifi-cli'

# Cleaner PATH output command
alias path='echo -e ${PATH//:/\\n}'

# Download web page with all assets
alias getpage='wget --no-clobber --page-requisites --html-extension --convert-links --no-host-directories'

# Download file with original filename
alias get="curl -O -L"

# Load modifications to zsh environment
alias reload!='. ~/.zshrc'
