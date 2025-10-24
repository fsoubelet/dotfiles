# -------------------------------- #
# Simple Utility Display Functions #
# -------------------------------- #

# A header print for homebrew update steps
func_header() {
    local tag="$1"; shift
    local fmt="$1"; shift

    # Color codes: try tput, fallback to ANSI
    local purple=$(tput setaf 5 2>/dev/null || echo -e "\033[35m")
    local reset=$(tput sgr0 2>/dev/null || echo -e "\033[0m")

    echo "---------------------------------------------------------" >&2
    printf "%s%s:%s %s\n" "$purple" "$tag" "$reset" "$fmt" >&2
    echo "---------------------------------------------------------" >&2
}


# A simple display with [tag] first
# Optional color can be passed as first arg
func_info() {
    local color="${1:-}"; shift
    local tag="$1"; shift
    local fmt="$1"; shift

    # Color codes: try tput, fallback to ANSI
    local reset=$(tput sgr0 2>/dev/null || echo -e "\033[0m")

    # Print with yellow tag in [] and then the rest of the message
    printf "%s[%s]%s %s\n" "$color" "$tag" "$reset" "$fmt" "$@" >&2
}
