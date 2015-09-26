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
    '~/.emacs.d':           'emacs',
    '~/.gitconfig':         'gitconfig',
    '~/.gitignore_global':  'gitignore_global',
    '~/.hammerspoon':       'hammerspoon',
    '~/.jshintrc':          'jshintrc',
    '~/.psqlrc':            'psqlrc',
    '~/.nvim':              'vim',
    '~/.nvimrc':            'vim/vimrc',
    '~/.vim':               'vim',
    '~/.vimrc':             'vim/vimrc',
    '~/.tmux.conf':         'tmux.conf',
    '~/.tigrc':             'tigrc',
    '~/.weechat':           'weechat',
    '~/.zshrc':             'zshrc',
    '~/Library/Application Support/Karabiner/private.xml': 'karabiner.xml',
}

# npm modules to install globally:
NPM_GLOBALS = ['jshint', 'jsonlint', 'json', 'gist-cli', 'stylus']


# Output a generic header for a section of the install script:
def section(name):
    print('\n\n' + name)
    print('='*40)


section('Symlinking config files to ~')
linked = []
skipped = []
for dest, source in SYMLINK_MAP.iteritems():
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



section('Installing global npm modules...')
check_cmd = 'npm ls -g --parseable ' + ' '.join(NPM_GLOBALS)
install_list = subprocess.check_output(check_cmd, shell=True)
if not install_list:
    cmd = 'npm install -g ' + ' '.join(NPM_GLOBALS)
    output = subprocess.check_output(cmd, shell=True)
    print output
else:
    print 'npm modules have been installed\n'


print('Done!')
