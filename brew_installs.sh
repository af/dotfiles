#!/bin/bash
brew install \
ack \
fasd \
nmap \
nodejs \
siege \
tig \
wget \
lua \
luajit \
ghi \
tmux \
reattach-to-user-namespace

# Install macvim with lua support
# Note: may need to install python via brew for this macvim to work
# See https://github.com/Homebrew/homebrew/issues/23709
brew install macvim --with-cscope --with-lua --with-luajit --override-system-vim
