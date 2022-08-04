# Dotfiles

<p align="center">
  <a href="https://xkcd.com/1319/">
    <img src="https://imgs.xkcd.com/comics/automation.png" />
  </a>
</p>


This folder contains my dotfiles, used on a mac currently running macOS Monterey (12.4).

## Package overview

This repository contains my configurations for a series of software and utilities that make my mac and the command line feel like home.
These include OS defaults and terminal profile as well as shell, git, editor and package manager configurations.

Here's some of the core software in my configuration:

* [iTerm2][iterm2] as terminal.
* The [Z shell][zsh] as shell.
* [Starship][starship] as prompt.
* [NeoVim][neovim] as modal editor.
* [Homebrew][homebrew] as package manager.

These will be installed automatically if not already present.

#### NeoVim

A modern modal editor, NeoVim is simply excellent.
I use [Vim-Plug][vim-plug] to manage plugins.
The plugins section is at the top of my `init.vim` file.
Vim-Plug should be auto-installed on the first NeoVim launch if it isn't already, as long as your `init.vim` is symlinked to the one in this repository.
After that, run `:PlugInstall` and enjoy a fully ready configuration.

#### Zsh

I run [Zsh][zsh] as my shell, finding it to be a great middle ground between additional niceties and features while remaining a largely compatible shell scripting target.
On top, I use [Oh-My-Zsh][oh-my-zsh] as shell configuration and plugin manager.

## Install

If git is already installed on your machine, you can clone this repository to your home folder.
Otherwise, you can simply download and unzip it from github.
Everything will be handled by the `Makefile` commands, so in the case of a git install simply run:

```
git clone https://github.com/fsoubelet/dotfiles.git ~/dotfiles
cd ~/dotfiles
make install
```

When in doubt you can run `make help`.

## Post-install

Some things are left to be done manually, specifically setting personnal information, installing profiles and changing some defaults.

* Set up iTerm2 profile (see below).
* Create a `~/.gitconfig.local` in which you can put personal data.
* Add a personnal touch to `~/.zshrc`  or other shell configuration files present in the `zsh` folder.
* If you wish to act on [macOS defaults][macos-defaults], customize the `macos_defaults.sh` file and run `make defaults`. This command is not ran by default.
* Choose a `spicetify` theme if you wish.

### Setting up iTerm2 profile (valid as of iTerm2 v3.3.0)

1. OPEN `iTerm2` > `Preferences`, or `cmd + ,`.
2. Under the `General` tab, `Preferences` section, check the box labeled `Load preferences from a custom folder or URL:`
3. Press "Browse" and point it to the `iterm2/com.googlecode.iterm2.plist` file located in this repository's `iterm` folder.
4. Restart iTerm2.

## Note

Currently, running `make` only works on macOS, but not every single installation point will be handled an the user might need to install some things manually.
If on a Linux distribution, have a look at the different targets (`make  help` will be useful) and run them individually.
Most of them should run without issue.

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
[starship]: https://github.com/starship/starship
[vim]: http://www.vim.org/
[vim-plug]: https://github.com/junegunn/vim-plug
[zsh]: https://en.wikipedia.org/wiki/Z_shell
