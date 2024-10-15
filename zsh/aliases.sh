# -------------------------------------------------------------------
# General UNIX
# -------------------------------------------------------------------
alias clr='clear'
alias cld='clr && lsd'
alias cp='cp -iv'
alias df='df -h'
alias ls='colorls'
alias lsg='colorls --git-status . --tree'
alias lsa='colorls -lA --sf'
alias lsd='eza --all --long --tree --icons --level=1'
alias mkdir='mkdir -pv'
alias mv='mv -iv'
alias th='trash'
alias rsync='rsync -ravzhP'
alias less='less -S'

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
alias gcl='git clone --depth=1'
alias gcm='git commit -S'  # automatically GPG sign the commits
alias gco='git checkout'
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
alias gwp='git commit -a -m wip --no-verify'  # use responsibly
alias gnvm='git reset --hard origin/main'  # better than rm -rf repo && git clone repo
alias gitout='gaa && gcm -m "fire!" && gps'  # emergency style

# Find all git repositories in current folder with max depth of 3 and do a 'git pull' in the current branch for each of them
alias git-pull-all="find . -maxdepth 3 -name .git -type d | rev | cut -c 6- | rev | xargs -P 10 -I {} git -C {} pull"
alias gpa='git-pull-all'
alias git-pull-all-verbose="find . -maxdepth 3 -name .git -type d | rev | cut -c 6- | rev | xargs -I {} sh -c 'echo {}; git -C {} pull'"
alias gpav='git-pull-all-verbose'

# -------------------------------------------------------------------
# Homebrew
# -------------------------------------------------------------------

alias bc='brew cleanup'
alias bd='brew doctor'
alias bg='brew upgrade --all'
alias bp='brew prune'
alias bo='brew outdated'
alias bu='brew update'
alias bf='rm -rf $(brew --prefix)/var/homebrew/locks'
alias bubc='brew upgrade && brew cleanup'
alias bubo='brew update && brew outdated'

# -------------------------------------------------------------------
# Python
# -------------------------------------------------------------------

# Let's use the best tool around
alias pip='uv pip'

# Easier Python virtual environment management, with uv
penv () {
  # Make a new virtual environment with uv, using provided python version
  uv venv -p "$1" --relocatable
  # Activating the environment
  source .venv/bin/activate
}

# Easier notebook aliases
alias jupylab='jupyter lab --browser=firefox --ContentsManager.allow_hidden=True'
alias jupy='jupylab'

# Command to upgrade all xsuite repos in the current environment
alias xsuite-upgrade='pip install --upgrade xsuite xtrack xpart xobjects xfields xcoll xplt'

# Alias to always start ipython in pylab mode (for non-blocking plot windows, mostly)
alias ipython='ipython --pprint --pylab'

# -------------------------------------------------------------------
# Conda / Mamba aliases
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

# Aliases to quickly create / destroy a simple test environment with mamba on latest Python
alias mtest='mamba create -n test python -y && mamba activate test'
alias dtest='conda deactivate && mamba remove -n test --all -y'

# Alias to list environments quickly
alias mel='mamba env list'

# Alias to remove an environment quickly
alias mrev='mamba env remove -y -n'  # add your env name 

# -------------------------------------------------------------------
# Safety first
# -------------------------------------------------------------------

_exists() {
  command -v "$1" > /dev/null 2>&1
}

# -------------------------------------------------------------------
# CERN & LXPLUS aliases
# -------------------------------------------------------------------

# /!\ Make sure to define a Host for cern in your .ssh/config file /!\

# Connecting directly into CERN desktop
alias desktop='ssh -J cern desktop'

# This is a python -m pip install looking at the AccPy indexes, useful for a lot of our internal packages. Requires GPN!!!
alias accpyp='python -m pip install --index-url http://acc-py-repo.cern.ch:8081/repository/vr-py-releases/simple --trusted-host acc-py-repo.cern.ch'

# -------------------------------------------------------------------
# CERN LHC Operations aliases
# -------------------------------------------------------------------

# THE MOST IMPORTANT OF ALL, should let us start the rest if need be
alias CCM='ssh -X technet2 /mcr/bin/ccm LHCOP'

# Open an ssh connection to cs-ccr-dev2 and start BetaBeat GUI from there
alias betabeatgui='ssh technet2 /mcr/bin/jws http://bewww.cern.ch/ap/deployments/applications/cern/lhc/lhc-app-beta-beating/PRO/BetaBeating-Control-3t.jnlp'

# Open an ssh connection to cs-ccr-dev2 and start OMC3 GUI from there
alias omc3gui='ssh technet2 /mcr/bin/jws http://bewww.cern.ch/ap/deployments/applications/cern/lhc/lhc-app-beta-beating-omc3/PRO/lhc-app-beta-beating-omc3-BetaBeatingOMC3-Control-3t.jnlp'

# Open an ssh connection to cs-ccr-dev2 and start Multiturn from there
#alias multiturn='ssh technet2 /mcr/bin/jws http://bewww.cern.ch/ap/deployments/applications/cern/sps/sps-multiturn/PRO/sps-multiturn-lhc-multiturn-pro.jnlp'

# Open an ssh connection to cs-ccr-dev2 and start TuneViewer Light from there
alias tuneviewer='ssh technet2 /mcr/bin/jws http://bewww.cern.ch/ap/deployments/applications/cern/accsoft/Tuneviewer/PRO/TuneViewerLight-LHC.jnlp'

# Open an ssh connection to cs-ccr-dev2 and start LSA Optics Application from there
alias lsaoptics='ssh technet2 /mcr/bin/jws http://bewww.cern.ch/ap/deployments/applications/cern/lsa/lsa-app-optics/PRO/lsa-app-optics.jnlp'

# Open an ssh connection to cs-ccr-dev2 and start BLM Fixed Display from there
alias blmdisplay='ssh technet2 /mcr/bin/jws http://bewww.cern.ch/ap/deployments/applications/cern/lhc/lhc-app-blm/PRO/lhc-app-blm-LHC-APP-BLM.jnlp'

# Open an ssh connection to cs-ccr-dev2 and start Accelerator Cockpit from there
alias accpit='ssh technet2 /mcr/bin/jws http://bewww.cern.ch/ap/deployments/applications/cern/lhc/lhc-app-accpit/PRO/lhc-app-accpit.jnlp'

# Open an ssh connection to cs-ccr-dev2 and start pykmod from there
alias pykmod='ssh technet2 /acc/local/share/python/acc-py/apps/acc-py-cli/pro/bin/acc-py app run pykmodlhc'

# Open an ssh connection to cs-ccr-dev2 and start pyLossMaps
#alias pylossmaps='ssh technet2 /acc/local/share/python/acc-py/apps/acc-py-cli/pro/bin/acc-py app run pylossmaps'

# Open an ssh connection to cs-ccr-dev2 and start the head-tail viewer
alias headtailviewer='ssh technet2 /acc/local/share/python/acc-py/apps/acc-py-cli/pro/bin/acc-py app run bqht-viewer'

# Open an ssh connection to cs-ccr-dev2 and start the BBQ trigger viewer
alias instabilitypanel='ssh technet2 /acc/local/share/python/acc-py/apps/acc-py-cli/pro/bin/acc-py app run instabilitypanel'

# Open an ssh connection to cs-ccr-dev2 and start LHC Wirescanner app from there
alias wirescanner='ssh technet2 /acc/local/share/python/acc-py/apps/acc-py-cli/pro/bin/acc-py app run ws-lhc-app'

# If need be, for some reason, to get jws again
# Don't forget to 'ln -s jws.sh /usr/local/bin/jws' afterwards or add the storing directory to PATH
alias get_jws='curl -o jws.sh http://www.cern.ch/ap/dist/devops/deploy/devops-deploy-jws/PRO/jws.sh'

# -------------------------------------------------------------------
# Miscellaneous
# -------------------------------------------------------------------

# oh-my-zsh
alias upz='omz update'

# Set up rlwarp for MAD-X and MAD-NG to use command history
# I put both of these into /usr/local/bin/
alias madx='rlwrap madx'
alias madng='rlwrap madng'

# Cleaner PATH output command
alias path='echo -e ${PATH//:/\\n}'

# Load modifications to zsh environment
alias reload!='. ~/.zshrc'
