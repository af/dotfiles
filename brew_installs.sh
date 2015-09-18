#!/bin/bash

brew install \
ack \
ag \
caskroom/cask/brew-cask \
curl \
fasd \
ghi \
git \
hub \
lua \
luajit \
ngrep \
ngrok \
nmap \
nvm \
redis \
reattach-to-user-namespace \
siege \
tig \
tmux \
weechat --with-perl --with-python \
wget \
zsh

brew tap neovim/neovim
brew install --HEAD neovim
