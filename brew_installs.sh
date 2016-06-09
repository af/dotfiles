#!/bin/bash

brew install \
ack \
ag \
caskroom/cask/brew-cask \
curl \
fasd \
ghi \
git \
gnu-sed --with-default-names \
heroku-toolbelt \
hub \
jq \
lua \
luajit \
ngrep \
nmap \
nvm \
redis \
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
