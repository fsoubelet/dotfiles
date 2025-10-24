# >>> conda initialize >>>
if [ -x "$HOME/.miniforge/bin/conda" ]; then
    __conda_setup="$("$HOME/.miniforge/bin/conda" shell.zsh hook 2> /dev/null)"
    if [ $? -eq 0 ]; then
        eval "$__conda_setup"
    elif [ -f "$HOME/.miniforge/etc/profile.d/conda.sh" ]; then
        source "$HOME/.miniforge/etc/profile.d/conda.sh"
    else
        export PATH="$HOME/.miniforge/bin:$PATH"
    fi
    unset __conda_setup
fi
# <<< conda initialize <<<

# >>> mamba initialize >>>
if [ -x "$HOME/.miniforge/bin/mamba" ]; then
    export MAMBA_EXE="$HOME/.miniforge/bin/mamba"
    export MAMBA_ROOT_PREFIX="$HOME/.miniforge"
    __mamba_setup="$("$MAMBA_EXE" shell hook --shell zsh --root-prefix "$MAMBA_ROOT_PREFIX" 2> /dev/null)"
    if [ $? -eq 0 ]; then
        eval "$__mamba_setup"
    else
        alias mamba="$MAMBA_EXE"
    fi
    unset __mamba_setup
fi
# <<< mamba initialize <<<
