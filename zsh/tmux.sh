# TODO: customize

# Makes creating a new tmux session (with a specific name) easier
function tn() {
  tmux new -s $1
}

# Makes attaching to an existing tmux session (with a specific name) easier
function ta() {
  tmux attach -t $1
}

# Makes deleting a tmux session easier
function tk() {
  tmux kill-session -t $1
}

# List tmux sessions
alias tl='tmux ls'

# Create a new session named for current directory, or attach if exists.
alias tna='tmux new-session -As $(basename "$PWD" | tr . -)'

# Source .tmux.conf
alias tsrc="tmux source-file ~/.tmux.conf"

# Kill all tmux sessions
alias tka="tmux ls | cut -d : -f 1 | xargs -I {} tmux kill-session -t {}" # tmux kill all sessions

# Useful for setting up tmuxinator envs
# http://stackoverflow.com/a/9976282/183537
alias tlw='tmux list-windows'

# Grab the current tmux layout and copy to pasteboard. (Relies on `copy` alias.)
# https://leanpub.com/the-tao-of-tmux/read#window-layouts
alias twcp='tmux lsw -F "#{window_active} #{window_layout}" | grep "^1" | cut -d " " -f2 | copy'

# Always in tmux :)
_not_inside_tmux() { [[ -z "$TMUX" ]] }

ensure_tmux_is_running() {
  if _not_inside_tmux; then
    tat
  fi
}

# ensure_tmux_is_running

. ~/bin/tmuxinator.zsh
