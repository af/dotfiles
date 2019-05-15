# dotfiles

My configuration for neovim, tmux, hammerspoon, zsh, etc. Some things are
Mac-specific, but most should work on any unix-ish OS.


## Setup

* (For macOS) [Install homebrew](http://brew.sh/)
* clone this repo (to `~/dotfiles` or similar)
* `./install.py`
* Install [fnm](https://github.com/Schniz/fnm)
* `fnm install <desired nodejs version>`
* `fnm alias <desired nodejs version> default`
* `af-npm-i-globals`
* `brew tap homebrew/services` (see https://superuser.com/a/1010357)


# Misc hacks

* To get italics working in the terminal see [this post](https://alexpearce.me/2014/05/italics-in-iterm2-vim-tmux/). Some files to use for the steps are in term/
