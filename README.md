# dotfiles

My configuration for neovim, tmux, hammerspoon, zsh, etc. Some things are
Mac-specific, but most should work on any unix-ish OS.


## Setup

* (For macOS) [Install homebrew](http://brew.sh/)
* clone this repo (to `~/dotfiles` or similar)
* Install fnm via `brew install Schniz/tap/fnm`
  * `fnm install <desired nodejs version>`
  * `fnm alias <desired nodejs version> default`
* `./install.py`
* `af-npm-i-globals`
* `tic term/tmux256.terminfo`
* homebrew font setup (see section below)
* `brew cask install alacritty`
* `brew tap homebrew/services` (see https://superuser.com/a/1010357)

## Homebrew font setup

via https://github.com/ryanoasis/nerd-fonts#option-4-homebrew-fonts

```bash
brew tap homebrew/cask-fonts
brew install --cask font-hack-nerd-font
```
