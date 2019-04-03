# Dotfiles

<p align="center">
  <a href="https://xkcd.com/1319/">
    <img src="https://imgs.xkcd.com/comics/automation.png" />
  </a>
</p>


This folder contains my dotfiles, used on a mac currently running macOS Mojave (10.14.4).


## Package overview

This repository contains my configurations for a series of software and utilities that make my mac and the command line feel like home.
These include OS defaults and terminal profile as well as shell, git, editors and package manager configurations.
An installation script is included to automatically implement them on a fresh new macOS machine.

The `install.sh` script will install some needed software and setup configuration files.
Here's some of the core software in my configuration:

* [iTerm][iterm2] as terminal.
* The [Z shell][zsh] as shell.
* [Vim][vim] as editor.
* [Homebrew][homebrew] as package manager.
* [Tmux][tmux] as terminal multiplexer.

These will be installed automatically if not already present.
The script will then backup your configuration files if already present, and symlink the new ones to those of this repository.

#### Vim

A classic modal editor, Vim is excellent.
I use [Vim-Plug][vim-plug] to manage plugins.
The section for plugins is at the beginning of my `vimrc` file, and with a few lines to auto-install Vim-Plug if it isn't already, so as long as your `~/.vimrc` is symlinked to `vimrc` in this repository, you can launch Vim, run `:PlugInstall` and enjoy a fully ready configuration.

#### Zsh

I run [Zsh][zsh] as my shell, finding it to be a great middle ground between additional niceties and features while remaining a largely compatible shell scripting target.
I use [Oh-My-Zsh][oh-my-zsh] as shell configuration manager and [Spaceship][spaceship] as my prompt, both of which are installed automatically.
If you don't wish to use this prompt, make sure to comment out its line in `oh_my_zsh_settings.sh` and craft your own.

#### Tmux

Tmux allows to combine processes, shells, and editors in any way for a project at hand.
Vim and tmux work seamlessly together thanks to the wonderful [vim-tmux-navigator][vim-tmux-navigator] plugin.

## Install

### Prerequisites

My go-to python distribution is the [Anaconda][anaconda] distribution.
It is recommended to install it before running the installation script.
You can download your favorite version [here][anacondadownload].

### Necessary tools

Make sure you have up-to-date software and Xcode command line tools.
On a sparkling fresh installation of macOS, run:

```
sudo softwareupdate -i -a
xcode-select --install
```

### Install with Git

```
git clone https://github.com/fsoubelet/dotfiles.git ~/dotfiles
bash ~/dotfiles/install.sh
```


## Post-install

The `install.sh` script leaves some things to be done manually, specifically setting personnal information, installing profiles and changing some defaults.

* Set up iTerm profile (see below).
* Create a `~/.gitconfig.local` in which you can put personal data.
* Add a personnal touch to `~/.zshrc`.
* If you wish to act on [macOS defaults][macos-defaults], customize `macos_defaults.sh`
 and run `bash ~/dotfiles/macos_defaults.sh`.


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
