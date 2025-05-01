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
# <<< conda initialize <<<

# >>> mamba initialize >>>
# !! Contents within this block are managed by 'mamba shell init' !!
export MAMBA_EXE='/Users/felixsoubelet/.miniforge/bin/mamba';
export MAMBA_ROOT_PREFIX='/Users/felixsoubelet/.miniforge';
__mamba_setup="$("$MAMBA_EXE" shell hook --shell zsh --root-prefix "$MAMBA_ROOT_PREFIX" 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__mamba_setup"
else
    alias mamba="$MAMBA_EXE"  # Fallback on help from mamba activate
fi
unset __mamba_setup
# <<< mamba initialize <<<