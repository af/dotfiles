#!/bin/bash
brew install \
ack \
ag \
fasd \
ghi \
hydra-cli \
lua \
luajit \
ngrok \
nmap \
nodejs \
reattach-to-user-namespace \
siege \
tig \
tmux \
weechat \
wget

# Install macvim with lua support
# Note: may need to install python via brew for this macvim to work
# See https://github.com/Homebrew/homebrew/issues/23709
brew install macvim --with-cscope --with-lua --with-luajit --override-system-vim
