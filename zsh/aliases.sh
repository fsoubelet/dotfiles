# -------------------------------------------------------------------
# General UNIX
# -------------------------------------------------------------------
alias clr='clear'
alias cclr='clear && archey && ls'
alias cdlr='cd && clear && archey && ls'
alias cld='clr && lsd'
alias cp='cp -iv'
alias df='df -h'
alias ls='colorls'
alias lsg='colorls --git-status . --tree'
alias lsa='colorls -lA --sf'
alias lsd='exa --all --long --tree --icons --level=1'
alias mkdir='mkdir -pv'
alias mv='mv -iv'
alias th='trash'
alias rsync='rsync -avhz'
alias gtp='gotop'

# A bit of cursing around: re-execute previous command as root
alias fuck='sudo $(fc -ln -1)'


# -------------------------------------------------------------------
# Global applications aliases
# -------------------------------------------------------------------
alias zshconfig="vi ~/.zshrc"

# Vim
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
alias gl='git log --graph --pretty=format:"%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset" --abbrev-commit --date=relative'
alias glg='git log --graph --stat --pretty=format:"%C(yellow bold)%h%Creset%C(white)%d%Creset %s%n %C(blue)%aN (%cd)%n"'
alias gm='git merge'
alias gpl='git pull'
alias gps='git push'
alias gra='git remote add'
alias grm='git rm'
alias grr='git remote rm'
alias gs='git status'
alias gta='git tag -am'
alias gfl='git flow'


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
# Docker aliases
# -------------------------------------------------------------------
alias docklean='docker rm $(docker ps -a -q -f status=exited)'                           # Delete all CONTAINERS that have a status of exited.
alias dock='docker rmi $(docker images --filter "dangling=true" --quiet --no-trunc)'     # Forcefully remove  DANGLING IMAGES.
alias dockrmi='docker rmi $(docker images -q) -f'                                        # Forcefully remove ALL IMAGES.
alias dockapocalypse='docker system prune -a'                                            # DANGEROUS. Will delete everything from docker!?
alias lzd='lazydocker'


# -------------------------------------------------------------------
# Conda aliases
# -------------------------------------------------------------------
_remove_last_lines () {
  # First argument is number of lines to remove, second is file name
  # Very fast because it reads from the end, does not read the whole file and doesn't rewrite un-necessary stuff 
  tail -n "$1" "$2" | wc -c | xargs -I {} truncate "$2" -s -{}
}

condexport () {
  # Export without build dir for provided name as argument under <name>_environment.yml
  conda env export > "$1"_environment.yml --no-builds --name "$1" --verbose
  # Get rid of the last two lines (one empty, one is prefix, platform specific)
  _remove_last_lines 2 "$1"_environment.yml
}

# -------------------------------------------------------------------
# Safety first
# -------------------------------------------------------------------

_exists() {
  command -v "$1" > /dev/null 2>&1
}


# -------------------------------------------------------------------
# CERN & LXPLUS aliases
# -------------------------------------------------------------------

# Make sure to define a Host for cern in your .ssh/config file

# Connecting directly into CERN desktop
alias desktop='ssh -J cern desktop'
alias deskjupy='ssh -N -L localhost:8888:localhost:8888 -J cern desktop'

# Connecting directly into CERN technical network
alias technet='ssh -J cern technet'

# Connecting directly into my CERN OpenStack machine
alias machine='ssh -J cern machine'

# Launching a jupyter notebook on remote and pipeline games to redirect output on localhost:4000 in local.
alias jupycern='ssh -L 4000:localhost:3000 cern "jupyter notebook --no-browser --ip=127.0.0.1 --port 3000"'

# If need be, for some reason, to get jws again
# Don't forget to 'ln -s jws.sh /usr/local/bin/jws' afterwards or add the storing directory to PATH
alias get_jws='curl -o jws.sh http://www.cern.ch/ap/dist/devops/deploy/devops-deploy-jws/PRO/jws.sh'


# -------------------------------------------------------------------
# Miscellaneous
# -------------------------------------------------------------------

# oh-my-zsh
alias upz='upgrade_oh_my_zsh'

# Easier notebook alias
alias jupy='jupylab'
alias jupylab='jupyter lab --browser=firefox'

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
