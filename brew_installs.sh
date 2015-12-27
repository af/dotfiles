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
tidy-html5 \
tig \
# tmux \        # Note: use patched version with 24-bit colour instead (see Readme)
weechat --with-perl --with-python \
wget \
zsh

brew tap neovim/neovim
brew install --HEAD neovim
