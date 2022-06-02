# -------------------------------------------------------------------
# General UNIX
# -------------------------------------------------------------------
alias clr='clear'
alias cclr='clear && neofetch && ls'
alias cdlr='cd && clear && neofetch && ls'
alias cld='clr && lsd'
alias cp='cp -iv'
alias df='df -h'
alias less='less -R'
alias lsg='colorls --git-status . --tree'
alias lsa='colorls -lA --sf'
alias lsd='exa --all --long --tree --icons --level=1'
alias mkdir='mkdir -pv'
alias mv='mv -iv'
alias th='rm -rf'
alias rsync='rsync -avhz'
alias gtp='gotop'
alias less='less -S'

# A bit of cursing around: re-execute previous command as root
alias fuck='sudo $(fc -ln -1)'

# Useful 'find' shortcuts
#alias fd='find . -type d -name'
#alias ff='find . -type f -name'

# -------------------------------------------------------------------
# Global applications aliases
# -------------------------------------------------------------------
alias zshconfig='vi ~/.zshrc'
alias vinit='vi ~/.config/nvim/init.vim'

# Vim
alias vi='vim'
alias vim='nvim'
alias nvim='/usr/bin/nvim'


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
# A convenient alias to see which files in git repo have been the most worked on
alias gitinspect='git log --format=format: --name-only | egrep -v "^$" | sort | uniq -c | sort -rg | head -10'

# Find all git repositories in current folder with max depth of 3 and do a 'git pull' in the current branch for each of them
alias git-pull-all="find . -maxdepth 3 -name .git -type d | rev | cut -c 6- | rev | xargs -I {} git -C {} pull"

# -------------------------------------------------------------------
# Docker aliases
# -------------------------------------------------------------------
alias docklean='docker rm $(docker ps -a -q -f status=exited)'                          # Delete all CONTAINERS that have a status of exited.
alias dock='docker rmi $(docker images --filter "dangling=true" --quiet --no-trunc)'    # Forcefully remove  DANGLING IMAGES.
alias dockrmi='docker rmi $(docker images -q) -f'                                       # Forcefully remove ALL IMAGES.
alias dockapocalypse='docker system prune -a'                                           # DANGEROUS. Will delete everything from docker!?
alias lzd='lazydocker'


# -------------------------------------------------------------------
# Conda aliases
# -------------------------------------------------------------------
alias cda='conda deactivate'
alias pip='python -m pip'

_remove_last_lines () {
  # First argument is number of lines to remove, second is file name
  # Very fast because it reads from the end, does not read the whole file and doesn't rewrite anything
  tail -n "$1" "$2" | wc -c | xargs -I {} truncate "$2" -s -{}
}

condexport () {
  # Export without build dir for provided name as argument under <name>_environment.yml
  conda env export > "$1"_environment.yml --no-builds --name "$1" --verbose
  # Get rid of the last two lines (one empty, one is prefix, platform specific)
  _remove_last_lines 2 "$1"_environment.yml
}

# Useful for re-creating or updating PHD env
alias makephdenv='conda install -c conda-forge hdf5 --yes && pip install --upgrade click cpymad fastparquet h5py htcondor ipykernel ipython isort jupyterlab-widgets loguru matplotlib numba numpy optics-functions pandas pendulum pip pyarrow pydantic pyhdtoolkit pynaff pytz requests rich scikit-learn scipy sdds seaborn sympy tfs-pandas generic-parser'

# -------------------------------------------------------------------
# Safety first
# -------------------------------------------------------------------

_exists() {
  command -v "$1" > /dev/null 2>&1
}


# -------------------------------------------------------------------
# CERN & LXPLUS aliases
# -------------------------------------------------------------------

# Because why not
alias jarjarbinks='bash /home/felix/Repositories/Work/Beta-Beat.src/jarjarbinks'

alias accpyp='pip install --index-url http://acc-py-repo.cern.ch:8081/repository/vr-py-releases/simple --trusted-host acc-py-repo.cern.ch'

# Make sure to define a Host for cern in your .ssh/config file
alias work='cd /afs/cern.ch/work/f/fesoubel/'
alias lintrack='cd /afs/cern.ch/eng/sl/lintrack/'
alias repos='cd /afs/cern.ch/eng/sl/lintrack/OMC_Repositories/'
alias optics='cd /afs/cern.ch/eng/lhc/optics/'

# Launching a jupyter notebook on remote and pipeline games to redirect output on localhost:4000 in local.
alias jupycern='ssh -L 4000:localhost:3000 cern "jupyter notebook --no-browser --ip=127.0.0.1 --port 3000"'

# If need be, for some reason, to get jws again
# Don't forget to 'ln -s jws.sh /usr/local/bin/jws' afterwards or add the storing directory to PATH
alias get_jws='curl -o jws.sh http://www.cern.ch/ap/dist/devops/deploy/devops-deploy-jws/PRO/jws.sh'

# Needs to have kinit-ed and aklog-ed, updates lxplus envs with local pyhdtoolkit build
alias get_omc_accpy='source /afs/cern.ch/eng/sl/lintrack/OMC_Acc_Py/base/2020.11/setup.sh'
alias omcenv='source /afs/cern.ch/eng/sl/lintrack/omc_python3/bin/activate'
alias update_omcenv='/afs/cern.ch/eng/sl/lintrack/omc_python3/bin/python -m pip install --upgrade pylhc pylhc_submitter tfs_pandas turn_by_turn omc3 sdds optics_functions generic_parser'
alias prodenv='source /afs/cern.ch/work/f/fesoubel/public/felix_prodenv/bin/activate'
alias update_prodenv='/home/felix/anaconda3/envs/PHD/bin/python -m pip uninstall pyhdtoolkit --yes && /home/felix/anaconda3/envs/PHD/bin/python -m pip install ~/Repositories/Work/PyhDToolkit/dist/pyhdtoolkit-*-py3-none-any.whl'

# MOST IMPORTANT REMOTE APP - CCM
alias CCM='ssh technet2 /mcr/bin/ccm LHCOP'

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

# -------------------------------------------------------------------
# Miscellaneous
# -------------------------------------------------------------------

# oh-my-zsh
alias upz='omz update'

# Easier notebook alias
alias jupy='jupylab'
alias jupylab='jupyter lab --browser=firefox'

# Cleaner PATH output command
alias path='echo -e ${PATH//:/\\n}'

# Download web page with all assets
alias getpage='wget --no-clobber --page-requisites --html-extension --convert-links --no-host-directories'

# Download file with original filename
alias get="curl -O -L"

# Load modifications to zsh environment
alias reload!='source ~/.zshrc'
