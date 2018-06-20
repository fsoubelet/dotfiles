This folder contains useful dotfiles that I use on my Mac, currently running macOS Sierra (10.12). Some usefull configuration files such as my iTerm2 profile are included.

## Prerequisites

These dotfiles assume you are running macOS with the following software:

* [Oh-My-Zsh][oh-my-zsh]
* [Homebrew][homebrew]
* [Vim][vim] and [Neovim][neovim]
* [Git][git]
* [Tmux][tmux]

## Implementation
```sh
git clone https://github.com/fsoubelet/dotfiles.git ~/dotfiles
. ~/dotfiles/install.sh
```

## Post-install

The `install.sh` script leaves some things to be done manually, specifically installing profiles, setting personnal information and changing some defaults.

* Set up iTerm2 profile (see below)
* Add personnal data to `~/.gitconfig.local`, `~/.vimrc.local`, and `~/.zshrc.local` if used.
* Complete [Brew Bundle][brew-bundle] with `brew bundle install`
* If you wish to act on [macOS defaults][macos-defaults], customize 'macos_defaults.sh' and run `. ~/dotfiles/macos_defaults.sh`.
* After opening Neovim, run [`:checkhealth`][checkhealth] and resolve errors/warnings.

## Setting up iTerm2

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
[tmux]: https://github.com/tmux/tmux/wiki
[vim]: http://www.vim.org/
