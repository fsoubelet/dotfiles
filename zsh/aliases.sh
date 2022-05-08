# -------------------------------------------------------------------
# General UNIX
# -------------------------------------------------------------------
alias clr='clear'
alias cclr='clear && neofetch && ls'
alias cdlr='cd && clear && neofetch && ls'
alias cld='clr & lsd'
alias cp='cp -iv'
alias df='df -h'
alias less='less -R -S'
alias lsa='ls -lA'
alias lsd='exa --all --long --tree --icons --level=1'
alias mkdir='mkdir -pv'
alias mv='mv -iv'
alias th='rm -rf'

alias fd='find . -type d -name'
alias ff='find . -type f -name'

alias view='vim -R'
alias vi='vim'

# Because you forget
alias :q='exit'
alias :w='echo "You are not in vim!"'
alias :wq='echo "You are not in vim!"'

# Moving around
alias work='cd /afs/cern.ch/work/f/fesoubel'
alias phd='cd /afs/cern.ch/work/f/fesoubel/PhD'

# A bit of cursing around
alias please='sudo $(fc -ln -1)'


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

# Find all git repositories in current folder with max depth of 3 and do a 'git pull' in the current branch for each of them
alias git-pull-all="find . -maxdepth 3 -name .git -type d | rev | cut -c 6- | rev | xargs -I {} git -C {} pull"

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
# CERN & LXPLUS aliases
# -------------------------------------------------------------------

# Starting the Kmod app when on technical server
# Careful that operations will not be accepted until login in (top right of app)
alias kmod='/acc/local/share/python/acc-py/apps/acc-py-cli/pro/bin/acc-py app run pykmodlhc'

# Useful when jumping to the optics server for apps
alias ssh='ssh -X'

# Moving around
alias lintrack='cd /afs/cern.ch/eng/sl/lintrack/'
alias repos='cd /afs/cern.ch/eng/sl/lintrack/OMC_Repositories/'

# HTCondor functionality on lxplus
alias bjobs='condor_q'
alias bsub='condor_submit' 
alias bkill='condor_rm fesoubel'
alias bhist='condor_history fesoubel'
alias bcheck='condor_tail -f -auto-retry' # need to add job ID afterwards

# If need be, for some reason, to get jws again
# Don't forget to 'ln -s jws.sh /usr/local/bin/jws' afterwards or add the storing directory to PATH
alias get_jws='curl -o jws.sh http://www.cern.ch/ap/dist/devops/deploy/devops-deploy-jws/PRO/jws.sh'

# Get a nice monitoring of basic HTCondor statuses
alias monitor='/afs/cern.ch/work/f/fesoubel/public/felix_prodenv/bin/python -m pyhdtoolkit.utils.htc_monitor'

# -------------------------------------------------------------------
# Miscellaneous
# -------------------------------------------------------------------

# oh-my-zsh
alias upz='omz update'

# Cleaner PATH output command
alias path='echo -e ${PATH//:/\\n}'

# Download web page with all assets
alias getpage='wget --no-clobber --page-requisites --html-extension --convert-links --no-host-directories'

# Download file with original filename
alias get="curl -O -L"

# Load modifications to zsh environment
alias reload!='. ~/.zshrc'
