#!/bin/bash
brew install \
ack \
ag \
fasd \
ngrok \
nmap \
nodejs \
siege \
tig \
wget \
lua \
luajit \
ghi \
tmux \
hydra-cli \
reattach-to-user-namespace

# Install macvim with lua support
# Note: may need to install python via brew for this macvim to work
# See https://github.com/Homebrew/homebrew/issues/23709
brew install macvim --with-cscope --with-lua --with-luajit --override-system-vim
