#!/usr/bin/env python

'''
Install script for dotfiles.

For now, just symlinks a bunch of files to ~.
'''
import os

SYMLINK_MAP = {
    'vim':          '~/.vim',
    'vim/vimrc':    '~/.vimrc',
}

# Assume this script is located the root of the dotfiles repo:
DOTFILES_ROOT = os.path.dirname(os.path.abspath(__file__))

for source, dest in SYMLINK_MAP.iteritems():
    source = os.path.join(DOTFILES_ROOT, source)
    dest = os.path.abspath(os.path.expanduser(dest))

    if (os.path.exists(dest)):
        print('skipped %s, file already exists' % dest)
    else:
        os.symlink(source, dest)
        print('symlinked %s to %s' % (source, dest))
