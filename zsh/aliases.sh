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

# A bit of cursing around: re-execute previous command as root
alias fuck='sudo $(fc -ln -1)'


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
alias work='cd /afs/cern.ch/work/f/fesoubel/'
alias lintrack='cd /afs/cern.ch/eng/sl/lintrack/'

# Launching a jupyter notebook on remote and pipeline games to redirect output on localhost:4000 in local.
alias jupycern='ssh -L 4000:localhost:3000 cern "jupyter notebook --no-browser --ip=127.0.0.1 --port 3000"'

# If need be, for some reason, to get jws again
# Don't forget to 'ln -s jws.sh /usr/local/bin/jws' afterwards or add the storing directory to PATH
alias get_jws='curl -o jws.sh http://www.cern.ch/ap/dist/devops/deploy/devops-deploy-jws/PRO/jws.sh'

# Needs to have kinit-ed and aklog-ed, updates lxplus envs with local pyhdtoolkit build
alias get_omc_accpy='source /afs/cern.ch/eng/sl/lintrack/OMC_Acc_Py/base/2020.11/setup.sh'
alias omcenv='/afs/cern.ch/eng/sl/lintrack/OMC_Python3/bin/python -m pip install --upgrade tfs-pandas generic_parser optics_functions pylhc-submitter sdds'
alias afsenvs='/afs/cern.ch/work/f/fesoubel/anaconda3/envs/PHD/bin/pip uninstall pyhdtoolkit --yes && /afs/cern.ch/work/f/fesoubel/anaconda3/envs/PHD/bin/pip install ~/Repositories/Work/PyhDToolkit/dist/pyhdtoolkit-*-py3-none-any.whl && /afs/cern.ch/work/f/fesoubel/anaconda3/envs/OMC/bin/pip uninstall pyhdtoolkit --yes && /afs/cern.ch/work/f/fesoubel/anaconda3/envs/OMC/bin/pip install ~/Repositories/Work/PyhDToolkit/dist/pyhdtoolkit-*-py3-none-any.whl'
alias updatenvs='source activate PHD && pip uninstall pyhdtoolkit --yes && pip install ~/Repositories/Work/PyhDToolkit/dist/pyhdtoolkit-*-py3-none-any.whl && conda deactivate'

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


# -------------------------------------------------------------------
# Random shit
# -------------------------------------------------------------------

# Shortcut to run Osu! from local build dir
alias osu!='dotnet run --project osu.Desktop -c Release'
