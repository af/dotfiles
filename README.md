# dotfiles

Rebuilding my dotfiles from scratch and putting them online for future reference.


## Setup

* (OS X) [Install homebrew](http://brew.sh/)
* Install homebrew dependencies with `./brew_installs.sh`
    * if not on a Mac, install the deps in that script some other way (apt-get, etc)
* (OS X) Install GUI apps with `./cask_installs.sh`
    * App Store.app will have several more things to install (XCode, etc)
    * also install [iTerm2 nightly](https://iterm2.com/downloads/nightly/)
      (for 24-bit colour support)
* clone this repo (to `~/dotfiles` or similar)
* `nvm install <current nodejs version>`
* `git submodule init && git submodule update`
* `./install.py`
