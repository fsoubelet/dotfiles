# Dotfiles

This folder contains my dotfiles, used on a mac currently running macOS Sierra (10.12).


## Package overview

This repository contains my configurations for a series of software and utilities that make my mac and the command line feel like home. These includes OS defaults and terminal profile as well as shell, git, editors and package manager configurations. An installation script is included to automatically implement them on a fresh new macOS machine.

The `install.sh` script will install some needed software and setup configuration files.
These dotfiles are meant to have your machine working with the following software:

* [iTerm][iterm2] as terminal.
* The [Z shell][zsh] as shell.
* [Oh-My-Zsh][oh-my-zsh] as shell configuration manager.
* [Spaceship][spaceship] as prompt theme. If you don't use it, make sure to comment out its line in `oh_my_zsh_settings.sh`.
* [Atom][atom] in macOS and [Vim][vim] and [Neovim][neovim] in terminal sessions as editors.
* [Homebrew][homebrew] as package manager.
* [Tmux][tmux] as terminal multiplexer.
* [Git][git] as versioning software.


These will be installed automatically if not already present. The script will then backup your configuration files if already present, and symlink thoses of this repository.

## Install

### Prerequisites

My go-to python distribution is the [Anaconda][anaconda] distribution. It is recommended to install it before running the installation script. You can download your favorite version [here][anacondadownload].

### Necessary tools

Make sure you have up-to-date software and Xcode command line tools. On a sparkling fresh installation of macOS, run:

```sh
sudo softwareupdate -i -a
xcode-select --install
```

### Install with Git

```sh
git clone https://github.com/fsoubelet/dotfiles.git ~/dotfiles
source ~/dotfiles/install.sh
```


## Post-install

The `install.sh` script leaves some things to be done manually, specifically setting personnal information, installing profiles and changing some defaults.

* Set up iTerm profile (see below).
* Add personnal data (and touch) to `~/.gitconfig.local`, and `~/.zshrc`.
* If you wish to act on [macOS defaults][macos-defaults], customize `macos_defaults.sh`
 and run `source ~/dotfiles/macos_defaults.sh`.
* After opening Neovim, run [`:checkhealth`][checkhealth] and resolve errors/warnings.


### Setting up iTerm2 profile

1. OPEN iTerm2 > Preferences.
2. Under the General tab, check the box labeled "Load preferences from a custom folder or URL:"
3. Press "Browse" and point it to `~/dotfiles/iterm2/com.googlecode.iterm2.plist`.
4. Restart iTerm2.


## License

Copyright &copy; 2018 Felix Soubelet. [MIT License][license]

[anaconda]: https://www.anaconda.com/
[anacondadownload]: https://www.anaconda.com/download/#macos
[atom]: https://atom.io/
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
[zsh]: https://en.wikipedia.org/wiki/Z_shell
