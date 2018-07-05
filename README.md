# Dotfiles

This folder contains my dotfiles, used on a mac currently running macOS Sierra (10.12).


## Package overview

This repository contains my configurations for a series of software and utilities that make my mac and the command line feel like home. These includes OS defaults and terminal profile as well as shell, git, editors and package manager configurations. An installation script is included to automatically implement them on a fresh new macOS machine.

## Prerequisites

These dotfiles assume you are running macOS with the following software:

* [Oh-My-Zsh][oh-my-zsh]
* [Git][git]
* [Homebrew][homebrew]
* [Spaceship][spaceship] prompt. If you don't use it, make sure to comment its line in `zshrc`. It's easy to find.
* [Tmux][tmux]
* [Vim][vim] and [Neovim][neovim]

## Install

### Necessary tools

Make sure you have up-to-date software and Xcode command line tools. On a sparkling fresh installation of macOS:

```sh
sudo softwareupdate -i -a
xcode-select --install
```

### Install with Git

```sh
git clone https://github.com/fsoubelet/dotfiles.git ~/dotfiles
. ~/dotfiles/install.sh
```


## Post-install

The `install.sh` script leaves some things to be done manually, specifically installing profiles, setting personnal information and changing some defaults.

* Set up iTerm2 profile (see below)
* Add personnal data to `~/.gitconfig.local`, `~/.vimrc.local`, and `~/.zshrc.local` if used.
* Complete [Brew Bundle][brew-bundle] with `brew bundle install`
* If you wish to act on [macOS defaults][macos-defaults], customize `macos_defaults.sh`
 and run `. ~/dotfiles/macos_defaults.sh`.
* After opening Neovim, run [`:checkhealth`][checkhealth] and resolve errors/warnings.


### Setting up iTerm2

Here are the steps to import your profile.

1. Open iTerm2.
1. Select iTerm2 > Preferences.
1. Under the General tab, check the box labeled "Load preferences from a custom folder or URL:"
1. Press "Browse" and point it to `~/dotfiles/iterm2/com.googlecode.iterm2.plist`.
1. Restart iTerm2.


## License

Copyright &copy; 2018 Felix Soubelet. [MIT License][license]

[brew-bundle]: https://github.com/Homebrew/homebrew-bundle
[checkhealth]: https://neovim.io/doc/user/pi_health.html#:checkhealth
[git]: https://git-scm.com/
[homebrew]: http://brew.sh
[iterm2]: https://www.iterm2.com/
[license]: https://github.com/fsoubelet/dotfiles/blob/master/LICENSE
[macos-defaults]: https://mths.be/macos
[neovim]: https://neovim.io/
[oh-my-zsh]: https://github.com/robbyrussell/oh-my-zsh
[spaceship]: https://github.com/denysdovhan/spaceship-prompt
[tmux]: https://github.com/tmux/tmux/wiki
[vim]: http://www.vim.org/
