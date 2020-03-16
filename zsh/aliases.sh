# -------------------------------------------------------------------
# General UNIX
# -------------------------------------------------------------------

alias clr='clear'
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
alias ip_coupling='cd /afs/cern.ch/work/f/fesoubel/PhD/STUDY.19.HLLHC.ip_problems/Compute_IP_Beam_Size_With_Coupling'
alias wipetracks='for FILE in track.obs0001.*; do rm -f "$FILE"; done && for FILE in track.obs0002.*; do rm -f "$FILE"; done'
alias clean_lhc='rm -f after_addingSkew.twiss bare_lhc before_correction_lhc dr_ptc_twiss_nnn.twiss internal_mag_pot.txt matched_lhc.twiss'
alias clean_hllhc='rm -f bare_hllhc.twiss before_correction_hllhc.twiss dr_ptc_twiss_nnn.twiss internal_mag_pot.txt matched_hllhc.twiss tfs_to_rdts.tfs'

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

# Avoid stupidity with trash-cli on macOs
if _exists trash; then
  alias rm='trash'
else
  alias rm='rm -i'
fi


# -------------------------------------------------------------------
# CERN & LXPLUS aliases
# -------------------------------------------------------------------

#alias machine='ssh -X root@fesoubel-lxplus'            # Connecting to my CERN openstack instance.
#alias technet='ssh -X cs-ccr-dev3'                        # Connecting into the technical network, to get access to slops.
alias ssh='ssh -X'

# Launching a jupyter notebook on remote and pipeline games to redirect output on localhost:4000 in local.
alias jupycern='ssh -L 4000:localhost:3000 fesoubel@lxplus.cern.ch "jupyter notebook --no-browser --ip=127.0.0.1 --port 3000"'


# HTCondor functionality on lxplus
alias bjobs='condor_q'
alias bsub='condor_submit' 

# If need be, for some reason, to get jws again
# Don't forget to 'ln -s jws.sh /usr/local/bin/jws' afterwards or add the storing directory to PATH
alias get_jws='curl -o jws.sh http://www.cern.ch/ap/dist/devops/deploy/devops-deploy-jws/PRO/jws.sh'

# -------------------------------------------------------------------
# Miscellaneous
# -------------------------------------------------------------------

# oh-my-zsh
alias upz='upgrade_oh_my_zsh'

# Cleaner PATH output command
alias path='echo -e ${PATH//:/\\n}'

# Download web page with all assets
alias getpage='wget --no-clobber --page-requisites --html-extension --convert-links --no-host-directories'

# Download file with original filename
alias get="curl -O -L"

# Load modifications to zsh environment
alias reload!='. ~/.zshrc'
