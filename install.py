#!/usr/bin/env python
'''
Install script for dotfiles:
    * symlinks a bunch of files to ~.
    * installs npm modules globally

Dependencies:
    * python (obviously)
    * node.js and npm
'''
import os
import subprocess

# Assume this script is located the root of the dotfiles repo:
DOTFILES_ROOT = os.path.dirname(os.path.abspath(__file__))
SYMLINK_MAP = {
    '~/.ctags':             'ctags',
    '~/.emacs.d':           'emacs',
    '~/.gitconfig':         'gitconfig',
    '~/.gitignore_global':  'gitignore_global',
    '~/.hammerspoon':       'hammerspoon',
    '~/.psqlrc':            'psqlrc',
    '~/.config/nvim':       'vim',
    '~/.vim':               'vim',
    '~/.vimrc':             'vim/init.vim',
    '~/.tmux.conf':         'tmux.conf',
    '~/.tigrc':             'tigrc',
    '~/.weechat':           'weechat',
    '~/.zshrc':             'zshrc',
    '~/Library/Preferences/kitty/kitty.conf': 'kitty.conf',
}


# Output a generic header for a section of the install script:
def section(name):
    print('\n\n' + name)
    print('='*40)


section('Symlinking config files to ~')
linked = []
skipped = []
for dest, source in SYMLINK_MAP.items():
    source = os.path.join(DOTFILES_ROOT, source)
    dest = os.path.abspath(os.path.expanduser(dest))

    if (os.path.exists(dest)):
        skipped.append([source, dest])
    else:
        linked.append([source, dest])
        os.symlink(source, dest)

skipped.sort()
linked.sort()
for source, dest in skipped:
    print('! skipped %-30s (file already exists)' % dest)
for source, dest in linked:
    print('symlinked %-25s ---> %s' % (dest, source))

print('Done!')
