# -------------------------------------------------------------------
# General UNIX
# -------------------------------------------------------------------
alias clr='clear'
alias cclr='clear && archey && ls'
alias cdlr='cd && clear && archey && ls'
alias cp='cp -iv'
alias df='df -h'
alias ls='colorls'
alias lsg='colorls --git-status . --tree'
alias lsa='colorls -lA --sf'
alias mkdir='mkdir -pv'
alias mv='mv -iv'
alias path='echo -e ${PATH//:/\\n}'

alias fd='find . -type d -name'
alias ff='find . -type f -name'

#alias grep='ack'
alias cat='bat'
alias exa='exa --all --long --tree --level=1'
alias find='fd'
alias rsync='rsync -avhz'

# Moving around
alias .2='cd ../../'
alias .3='cd ../../../'
alias .4='cd ../../../../'
alias .5='cd ../../../../..'
[ -d ~/Desktop ]   && alias dt='cd ~/Desktop'
[ -d ~/dotfiles ]  && alias dotfiles='cd ~/dotfiles'
[ -d ~/Downloads ] && alias dl='cd ~/Downloads'
[ -d ~/Dropbox ]   && alias dr='cd ~/Dropbox'
[ -d ~/cernbox ]   && alias cb='cd ~/cernbox'

# A bit of cursing around
alias fuck='sudo $(fc -ln -1)'


# -------------------------------------------------------------------
# Global applications aliases
# -------------------------------------------------------------------
alias atom="open -a 'Atom.app'"
alias code="open -a 'Xcode.app'"
alias zshconfig="vi ~/.zshrc"
alias pycharm='open -a PyCharm.app'
alias gtp='gotop'


# Vim/Neovim
alias vim="/usr/local/bin/vim"


# -------------------------------------------------------------------
# Git aliases
# -------------------------------------------------------------------
alias ga='git add'
alias gaa='git add --all -v'
alias gb='git branch'
alias gba='git branch --all'
alias gbd='git branch -d'
alias gcl='git clone'
alias gcm='git commit'
alias gco='git checkout'
alias gcom='git checkout master'
alias gd='git diff'
alias gdf='git diff --word-diff --color-words'
alias gf='git fetch'
alias gl='git log --date=format:"%b %d, %Y" --oneline --decorate --all --graph --pretty=format:"%C(yellow bold)%h%Creset%C(white)%d%Creset %s%n %C(blue)%aN (%cd)%n"'
alias glg='git log --graph --stat --pretty=format:"%C(yellow bold)%h%Creset%C(white)%d%Creset %s%n %C(blue)%aN (%cd)%n"'
alias gm='git merge'
alias gpl='git pull'
alias gps='git push'
alias gra='git remote add'
alias grm='git rm'
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
alias bubc='brew upgrade && brew cleanup'
alias bubo='brew update && brew outdated'


# -------------------------------------------------------------------
# Safety first
# -------------------------------------------------------------------

_exists() {
  command -v $1 > /dev/null 2>&1
}


# -------------------------------------------------------------------
# CERN & LXPLUS aliases
# -------------------------------------------------------------------

alias sshcern='ssh -X fesoubel@lxplus.cern.ch'       # Remote connection into LXPLUS x86_64 running SLC6. Set to be replaced by CC7 in the future.

# Copying files from remote CERN afs to local     scp -r cern:/full_path/to/origin /local_path/destination
# Copying files from local to remote CERN afs     scp -r /local_path/origin cern:/full_path/to/destination
# Make sure to have a ~/.ssh.config file containing
# Host cern
#   User fesoubel
#   Hostname lxplus.cern.ch

# Launching a jupyter notebook on remote and pipeline games to redirect output on localhost:4000 in local.
alias jupycern='ssh -L 4000:localhost:3000 fesoubel@lxplus7.cern.ch "jupyter notebook --no-browser --ip=127.0.0.1 --port 3000"' # For CC7 environment.

# If need be, for some reason, to get jws again
# Don't forget to 'ln -s jws.sh /usr/local/bin/jws' afterwards or add the storing directory to PATH
alias get_jws='curl -o jws.sh http://www.cern.ch/ap/dist/devops/deploy/devops-deploy-jws/PRO/jws.sh'

# -------------------------------------------------------------------
# Miscellaneous
# -------------------------------------------------------------------

# oh-my-zsh
alias upz='upgrade_oh_my_zsh'

# Easier notebook alias
alias jupy='jupyter notebook --browser=safari'
alias jupylab='jupyter lab --browser=safari'

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
