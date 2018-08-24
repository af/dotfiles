# dotfiles

My configuration for neovim, tmux, hammerspoon, zsh, etc. Some things are
Mac-specific, but most should work on any unix-ish OS.


## Setup

* (For macOS) [Install homebrew](http://brew.sh/)
* clone this repo (to `~/dotfiles` or similar)
* `./install.py`
* `nvm install <desired nodejs version>`
* `af-npm-i-globals`
* `brew tap homebrew/services` (see https://superuser.com/a/1010357)


# Misc hacks

* iTerm2/Neovim don't play together well for my ctrl-h mappings. [Workaround
  here](https://github.com/neovim/neovim/issues/2048#issuecomment-78045837)
* To get italics working in the terminal see [this post](https://alexpearce.me/2014/05/italics-in-iterm2-vim-tmux/). Some files to use for the steps are in term/
