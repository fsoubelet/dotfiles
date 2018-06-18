#!/usr/bin/env bash

################################################################################
# install
#
# This script symlinks the dotfiles into place in the home directory.
################################################################################

dotfiles_echo() {
  local fmt="$1"; shift

  # shellcheck disable=SC2059
  printf "\\n[DOTFILES] $fmt\\n" "$@"
}

# Terminate script if anything exits with a non-zero value
set -e


DOTFILES_DIR=$HOME/dotfiles
VIM_DIR=$HOME/.vim
NVIM_DIR=$HOME/.config/nvim

files=(

)

dotfiles_echo "Installing dotfiles"

for file in "${files[@]}"; do
