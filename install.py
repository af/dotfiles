#!/usr/bin/env python
'''
Install script for dotfiles.

For now, just symlinks a bunch of files to ~.
'''
import os

# Assume this script is located the root of the dotfiles repo:
DOTFILES_ROOT = os.path.dirname(os.path.abspath(__file__))
SYMLINK_MAP = {
    'vim':          '~/.vim',
    'vim/vimrc':    '~/.vimrc',
    'jshintrc':     '~/.jshintrc',
}

linked = []
skipped = []
for source, dest in SYMLINK_MAP.iteritems():
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
    print('skipped %-40s (file already exists)' % dest)

print('')
for source, dest in linked:
    print('symlinked %-40s to %s' % (dest, source))
