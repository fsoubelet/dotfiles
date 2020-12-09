# -------------------------------------------------------------------
# General UNIX
# -------------------------------------------------------------------

alias clr='clear'
alias cld='clr & ls -la'
alias cclr='clear && neofetch && ls'
alias cdlr='cd && clear && neofetch && ls'
alias cp='cp -iv'
alias df='df -h'
alias lsl='ls -l'
alias lsa='ls -lA'
alias mkdir='mkdir -pv'
alias mv='mv -iv'

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
alias wipetracks='for FILE in track.obs0001.*; do rm -f "$FILE"; done && for FILE in track.obs0002.*; do rm -f "$FILE"; done'

# A bit of cursing around
alias please='sudo $(fc -ln -1)'


# -------------------------------------------------------------------
# Global applications aliases
# -------------------------------------------------------------------

alias gtp'gotop'


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

alias ssh='ssh -X'
alias schedule='/afs/cern.ch/work/f/fesoubel/anaconda3/envs/OMC/bin/python /afs/cern.ch/work/f/fesoubel/public/Repositories/PyLHC/pylhc/job_submitter.py'

# HTCondor functionality on lxplus
alias bjobs='condor_q'
alias bsub='condor_submit' 
alias bkill='condor_rm fesoubel'
alias bhist='condor_history fesoubel'

# If need be, for some reason, to get jws again
# Don't forget to 'ln -s jws.sh /usr/local/bin/jws' afterwards or add the storing directory to PATH
alias get_jws='curl -o jws.sh http://www.cern.ch/ap/dist/devops/deploy/devops-deploy-jws/PRO/jws.sh'

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
