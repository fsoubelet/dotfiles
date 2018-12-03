# Dotfiles

This folder contains my dotfiles, used on a mac currently running macOS Mojave (10.14.1).


## Package overview

This repository contains my configurations for a series of software and utilities that make my mac and the command line feel like home. These include OS defaults and terminal profile as well as shell, git, editors and package manager configurations. An installation script is included to automatically implement them on a fresh new macOS machine.

The `install.sh` script will install some needed software and setup configuration files. Here's some of the core software in my configuration:

* [iTerm][iterm2] as terminal.
* The [Z shell][zsh] as shell.
* [Atom][atom] in macOS and [Vim][vim] and [Neovim][neovim] in terminal sessions as editors.
* [Homebrew][homebrew] as package manager.
* [Tmux][tmux] as terminal multiplexer.


These will be installed automatically if not already present. The script will then backup your configuration files if already present, and symlink thoses of this repository.

#### Atom

Atom is my choice editor when on macOS. I keep my packages in sync with [package-sync][package-sync]. the installation script takes care of symlinking `~/.atom/packages.cson` to the `atom/packages.cson` file of this repository. To implement your packages, you can use the `Create Package List` command to create your `packages.cson` file and overwrite mine. Package-sync will download and install your packages when starting Atom. You may have to set your themes manually.

#### Neovim

Even though Atom is my choice editor, it so happens that I can't use it in ssh sessions, and need a classic modal editor. Neovim is an excellent in-terminal editor, that I run with [vim-plug][vim-plug] to manage plugins. The many plugins I use can be found in `config/nvim/plugins.vim`, which you can configure to your convenience.

#### Zsh

I run [Zsh][zsh] as my shell, finding it to be a great middle ground between additional niceties and features while remaining a largely compatible shell scripting target. I use [Oh-My-Zsh][oh-my-zsh] as shell configuration manager and [Spaceship][spaceship] as my prompt, both of which are installed automatically. If you don't with to use this prompt, make sure to comment out its line in `oh_my_zsh_settings.sh` and craft your own.

#### Tmux

Tmux allows to combine processes, shells, and editors in any way for a project at hand. Vim and tmux work seamlessly together thanks to the wonderful [vim-tmux-navigator][vim-tmux-navigator] plugin.

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
sh ~/dotfiles/install.sh
```


## Post-install

The `install.sh` script leaves some things to be done manually, specifically setting personnal information, installing profiles and changing some defaults.

* Set up iTerm profile (see below).
* Add personnal data (and touch) to `~/.gitconfig.local`, and `~/.zshrc`.
* If you wish to act on [macOS defaults][macos-defaults], customize `macos_defaults.sh`
 and run `sh ~/dotfiles/macos_defaults.sh`.
* After opening Neovim, run [`:checkhealth`][checkhealth] and resolve errors/warnings.


### Setting up iTerm2 profile

1. OPEN iTerm2 > Preferences.
2. Under the General tab, check the box labeled "Load preferences from a custom folder or URL:"
3. Press "Browse" and point it to `~/dotfiles/iterm2/com.googlecode.iterm2.plist`.
4. Restart iTerm2.


## Credits

Many thanks to the [dotfiles community][dotcomu] and the [awesome dotfiles][awesomedots] repository.

## License

Copyright &copy; 2018 Felix Soubelet. [MIT License][license]

[anaconda]: https://www.anaconda.com/
[anacondadownload]: https://www.anaconda.com/download/#macos
[atom]: https://atom.io/
[awesomedots]: https://github.com/webpro/awesome-dotfiles
[brew-bundle]: https://github.com/Homebrew/homebrew-bundle
[checkhealth]: https://neovim.io/doc/user/pi_health.html#:checkhealth
[dotcomu]: https://dotfiles.github.io/
[git]: https://git-scm.com/
[homebrew]: http://brew.sh
[iterm2]: https://www.iterm2.com/
[license]: https://github.com/fsoubelet/dotfiles/blob/master/LICENSE
[macos-defaults]: https://mths.be/macos
[neovim]: https://neovim.io/
[oh-my-zsh]: https://github.com/robbyrussell/oh-my-zsh
[package-sync]: https://atom.io/packages/package-sync
[spaceship]: https://github.com/denysdovhan/spaceship-prompt
[tmux]: https://github.com/tmux/tmux/wiki
[vim]: http://www.vim.org/
[vim-plug]: https://github.com/junegunn/vim-plug
[vim-tmux-navigator]: https://github.com/christoomey/vim-tmux-navigator
[zsh]: https://en.wikipedia.org/wiki/Z_shell
