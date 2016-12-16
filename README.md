# dotfiles

My configuration for (neo)vim, tmux, hammerspoon, zsh, etc. Some things are
Mac-specific, but most should work on any unix-ish OS.


## Setup

* (OS X) [Install homebrew](http://brew.sh/)
* Install homebrew dependencies with `./brew_installs.sh`
    * if not on a Mac, install the deps in that script some other way (apt-get, etc)
* (OS X) Install GUI apps with `./cask_installs.sh`
    * App Store.app will have several more things to install (XCode, etc)
    * install [iTerm2 nightly](https://iterm2.com/downloads/nightly/) or 3.0
      for 24-bit colour support
* clone this repo (to `~/dotfiles` or similar)
* `nvm install <current nodejs version>`
* `git submodule init && git submodule update`
* `./install.py`
* For neovim plugin support, run `pip install neovim --user` and `pip3 install neovim --user`


# Misc hacks

* iTerm2/Neovim don't play together well for my ctrl-h mappings. [Workaround
  here](https://github.com/neovim/neovim/issues/2048#issuecomment-78045837)
