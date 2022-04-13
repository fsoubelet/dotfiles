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
alias less='less -S'

alias sush='sort | uniq -c | sort -nr | head'

# A bit of cursing around: re-execute previous command as root
alias fuck='sudo $(fc -ln -1)'

# -------------------------------------------------------------------
# Global applications aliases
# -------------------------------------------------------------------
alias zshconfig='vi ~/.zshrc'
alias vinit='vi ~/.config/nvim/init.vim'

# NeoVim
alias vi='vim'
alias vim='nvim'


# -------------------------------------------------------------------
# Git aliases
# -------------------------------------------------------------------
alias ga='git add'
alias gaa='git add --all -v'
alias gb='git branch'
alias gba='git branch --all'
alias gbd='git branch -d'
alias gcl='git clone'
alias gcm='git commit -S'  # automatically GPG sign the commits
alias gco='git checkout'
alias gcom='git checkout master'
alias gd='git diff'
alias gdf='git diff --word-diff --color-words'
alias gf='git fetch'
alias gl='git log --graph --pretty=format:"%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset" --abbrev-commit --date=relative'
alias glg='git log --graph --stat --pretty=format:"%C(yellow bold)%h%Creset%C(white)%d%Creset %s%n %C(blue)%aN (%cd)%n"'
alias gll='git log --pretty=format:"%C(auto,yellow)%h%C(auto,magenta)% G? %C(auto,blue)%>(30,trunc)%ad %C(auto,green)%<(17,trunc)%aN%C(auto,reset)%s%C(auto,red)% gD% D"'
alias gm='git merge'
alias gpl='git pull'
alias gps='git push'
alias gra='git remote add'
alias grm='git rm'
alias grr='git remote rm'
alias gs='git status'
alias gta='git tag -sm'  # automatically GPG sign and annotate tags
alias gfl='git flow'

alias gitout='gaa && gcm -m "fire!" && gps'  # emergency style

# Find all git repositories in current folder with max depth of 3 and do a 'git pull' in the current branch for each of them
alias git-pull-all="find . -maxdepth 3 -name .git -type d | rev | cut -c 6- | rev | xargs -I {} git -C {} pull"


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
# Conda aliases
# -------------------------------------------------------------------
alias cda='conda deactivate'

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

# Useful for re-creating or updating PHD env / NEEDS REWORK
# alias makephdenv='conda install -c conda-forge hdf5 --yes && pip install --upgrade click cpymad h5py ipykernel ipython isort jupyterlab-widgets loguru matplotlib numba numpy optics-functions pandas pendulum pip pyarrow pydantic pyhdtoolkit pynaff pytz requests rich scikit-learn scipy sdds seaborn sympy tfs-pandas generic-parser'

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

# Connecting directly into CERN technical network
alias technet='ssh -J cern technet'

# If need be, for some reason, to get jws again
# Don't forget to 'ln -s jws.sh /usr/local/bin/jws' afterwards or add the storing directory to PATH
alias get_jws='curl -o jws.sh http://www.cern.ch/ap/dist/devops/deploy/devops-deploy-jws/PRO/jws.sh'

# Establish a SOCKS5 proxy through CERN to access GPN restricted resources
# Then go to System Preferences -> Network -> Advanced -> Proxies -> Tick SOCKS and configure with 127.0.0.1 and port 8090
alias cernprox='ssh -D 8090 tunnel'

# -------------------------------------------------------------------
# Miscellaneous
# -------------------------------------------------------------------

# oh-my-zsh
alias upz='omz update'

# Setup analysis from cookiecutter
alias analyze='cookiecutter gh:fsoubelet/cookiecutter-analysis'

# Sourced mkdocs command
alias pydoc='~/anaconda3/envs/docmc/bin/python -m mkdocs'

# Safety in pip operations
alias pip='python -m pip'

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

# Download an entire profile's videos
alias ytdl_user='youtube-dl -f "bestvideo[height>=720]+bestaudio/best" -ciw -o "%(title)s.%(ext)s" -v'
