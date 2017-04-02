#!/bin/bash

brew install \
ag \
caskroom/cask/brew-cask \
ctags \
curl \
fasd \
ghi \
git \
gnu-sed --with-default-names \
heroku-toolbelt \
hub \
jq \
ngrep \
nmap \
nvm \
pip3 \
python3 \
reattach-to-user-namespace \
siege \
tidy-html5 \
tig \
tmux \
weechat --with-perl --with-python \
wget \
zsh

brew tap neovim/neovim
brew install --HEAD neovim
