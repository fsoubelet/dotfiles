# ---------------------------- #
# Utility functions for Python #
# ---------------------------- #

# Python virtual environment management, with uv
# Expects the Python version to use as variable
penv () {
    local python_version="$1"

    # Color codes (use tput if available, fallback to ANSI)
    local green=$(tput setaf 2 2>/dev/null || echo -e "\033[32m")
    local red=$(tput setaf 1 2>/dev/null || echo -e "\033[31m")
    local yellow=$(tput setaf 3 2>/dev/null || echo -e "\033[33m")
    local reset=$(tput sgr0 2>/dev/null || echo -e "\033[0m")

    # Check that uv is available on the system
    if ! _exists uv; then
        func_info "${red}Error:${reset}" "'uv' command not found. Please install it first." >&2
        return 1
    fi

    # Check if venv already exists there
    if [[ -d ".venv" ]]; then
        func_info "${yellow}Warning:${reset}" ".venv already exists. Replace it? [y/N]" >&2
        read -r ans
        [[ "$ans" =~ ^[Yy]$ ]] || return 0
        rm -rf .venv
    fi

    # Create and activate the venv with uv
    if ! uv venv --python "$python_version" --relocatable; then
        func_info "${red}Error:${reset}" "Failed to create virtual environment." >&2
        return 1
    fi

    # Activate created environment safely
    if [[ -f ".venv/bin/activate" ]]; then
        # shellcheck disable=SC1091
        source .venv/bin/activate
        func_info "${green}Success:${reset}" "Virtual environment activated"
    else
        func_info "${red}Error:${reset}" ".venv/bin/activate not found." >&2
        return 1
    fi
}


# Python virtual environment deletion (assumes env made as above and activated)
# Automatically determines the env location, deactivates then deletes it
pdel () {
    # Color codes (use tput if available, fallback to ANSI)
    local red=$(tput setaf 1 2>/dev/null || echo -e "\033[31m")
    local blue=$(tput setaf 4 2>/dev/null || echo -e "\033[34m")
    local yellow=$(tput setaf 3 2>/dev/null || echo -e "\033[33m")
    local green=$(tput setaf 2 2>/dev/null || echo -e "\033[32m")
    local reset=$(tput sgr0 2>/dev/null || echo -e "\033[0m")

    # Figure out the virtual environment (we might not be in that place anymore)
    # this keeps the loc and removes last 2 parts, which are the /bin/python
    local pybin envloc
    pybin=$(command -v python 2>/dev/null) || {
        echo "${red}Error:${reset} Python executable not found." >&2
        return 1
    }
    envloc=$(dirname "$(dirname "$pybin")")

    # We check first that it's not a conda environment
    if [[ $envloc == $HOME/.miniforge* ]]; then  # regex check for presence in env path
        echo "${yellow}Abort:${reset} Not touching conda environments with this command." >&2
        return 0
    fi

    # Remove the environment (use th if available)
    echo "Removing environment at ${blue}${envloc}${reset}"
    if command -v th >/dev/null 2>&1; then
        th "$envloc"
    else
        rm -rf "$envloc"
    fi

    echo "${green}Success:${reset} Environment removed."
}
