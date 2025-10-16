# -------------------------------------------------------------------
# General UNIX
# -------------------------------------------------------------------
alias clr='clear'
alias cld='clr && lsd'
alias cp='cp -iv'
alias df='df -h'
alias ls='colorls'
alias lsd='eza --all --long --tree --icons --level=0'
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
alias gcl='git clone --depth=1'
alias gcm='git commit -S'  # automatically GPG sign the commits
alias gcmf='gcm -m "formatting"'  # for simple formatting commits
alias gco='git checkout'
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
# Python
# -------------------------------------------------------------------

# Let's use the best tool around
alias pip='uv pip'

# Regularly need to make sure of this
alias wp='which python'
alias pv='python --version'

# Activating everywhere
alias senv='source .venv/bin/activate'

# Quick aliases for the uv tools
alias usu='uv self update'
alias uta='uv tool upgrade --all'
alias upi='uv python install --reinstall'
alias uvi='uvx isort'
alias uvb='uvx black'
alias uvr='uvx ruff'

# Easier notebook aliases
alias jupylab='jupyter lab --browser=firefox --ContentsManager.allow_hidden=True'
alias jupy='jupylab'

# To run marimo notebooks through uv tool
alias marimo='uvx marimo'

# Command to upgrade all xsuite repos in the current environment: x(suite-up)grade
alias xgrade='pip install --upgrade --compile-bytecode setuptools xsuite xtrack xpart xobjects xfields xcoll xplt pint'

# -------------------------------------------------------------------
# Conda / Mamba aliases
# -------------------------------------------------------------------

alias cda='conda deactivate'

_remove_last_lines () {
  # argument $1 = number of lines to remove, argument $2 = filename
  local lines_to_keep
  # Compute total lines - lines to remove
  lines_to_keep=$(( $(wc -l < "$2") - $1 ))
  # Guard against negative values, you never know
  if [ "$lines_to_keep" -lt 0 ]; then
    lines_to_keep=0
  fi
  # Use head (portable, not like truncate) to keep only the wanted lines
  # First go through a temp file just in case then move (force) piping to devnul
  head -n "$lines_to_keep" "$2" > "$2.tmp" && mv -f "$2.tmp" "$2" > /dev/null 2>&1
}

condexport () {
  # Export without build dir for provided name as argument under <name>_environment.yml
  conda env export --name "$1" --no-builds --verbose > "$1"_environment.yml
  # Get rid of the last line (platform-specific prefix)
  _remove_last_lines 1 "$1"_environment.yml
}

# Aliases to quickly create / destroy a simple test environment with mamba on latest Python
alias mtest='mamba create -n test python -y && mamba activate test'
alias dtest='conda deactivate && mamba env remove -n test -y'

# Aliases to manage miniforge environments quickly
alias mel='mamba env list'
alias mrev='mamba env remove -y -n'  # add your env name

# -------------------------------------------------------------------
# CERN & LXPLUS aliases
# -------------------------------------------------------------------

# This is a python -m pip install looking at the AccPy indexes, useful for a lot of our internal packages. Requires GPN!!!
alias accpip='python -m pip install --index-url https://acc-py-repo.cern.ch:8081/repository/vr-py-releases/simple --trusted-host acc-py-repo.cern.ch'

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
