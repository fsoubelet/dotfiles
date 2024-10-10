# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/felixsoubelet/.miniforge/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/felixsoubelet/.miniforge/etc/profile.d/conda.sh" ]; then
        . "/Users/felixsoubelet/.miniforge/etc/profile.d/conda.sh"
    else
        export PATH="/Users/felixsoubelet/.miniforge/bin:$PATH"
    fi
fi
unset __conda_setup

if [ -f "/Users/felixsoubelet/.miniforge/etc/profile.d/mamba.sh" ]; then
    . "/Users/felixsoubelet/.miniforge/etc/profile.d/mamba.sh"
fi
# <<< conda initialize <<<