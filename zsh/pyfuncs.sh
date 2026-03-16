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

    # Check that uv is available on the system
    if ! _exists uv; then
        func_info "$red" "Error" "'uv' command not found. Please install it first." >&2
        return 1
    fi

    # Check if venv already exists there
    if [[ -d ".venv" ]]; then
        func_info "$yellow" "Warning" ".venv already exists. Replace it? [y/N]" >&2
        read -r ans
        [[ "$ans" =~ ^[Yy]$ ]] || return 0
        rm -rf .venv
    fi

    # Create and activate the venv with uv
    if ! uv venv --python "$python_version" --relocatable; then
        func_info "$red" "Error" "Failed to create virtual environment." >&2
        return 1
    fi

    # Activate created environment safely
    if [[ -f ".venv/bin/activate" ]]; then
        # shellcheck disable=SC1091
        source .venv/bin/activate
        func_info "$green" "Success" "Virtual environment activated"
    else
        func_info "$red" "Error" ".venv/bin/activate not found." >&2
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
        func_info "$red" "Error" "Python executable not found." >&2
        return 1
    }
    envloc=$(dirname "$(dirname "$pybin")")

    # We check first that it's not a conda environment
    if [[ $envloc == $HOME/.miniforge* ]]; then  # regex check for presence in env path
        func_info "$yellow" "Abort" "Not touching conda environments with this command." >&2
        return 0
    fi

    # Remove the environment (use th if available)
    echo "Removing environment at ${blue}${envloc}${reset}"
    if command -v trash >/dev/null 2>&1; then
        trash "$envloc"
    else
        rm -rf "$envloc"
    fi

    func_info "$green" "Success" "Environment removed."
}


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


# Conda environment export without build info
# Usage: condexport <env_name>
condexport () {
    # Export without build dir for provided name as argument under <name>_environment.yml
    conda env export --name "$1" --no-builds --verbose > "$1"_environment.yml

    # Get rid of the last line (platform-specific prefix)
    _remove_last_lines 1 "$1"_environment.yml
}
