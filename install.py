#!/usr/bin/env python
'''
Install script for dotfiles:
    * symlinks a bunch of files to ~
    * installs homebrew and pip dependencies
'''
import os
import subprocess

# Assume this script is located the root of the dotfiles repo:
DOTFILES_ROOT = os.path.dirname(os.path.abspath(__file__))
SYMLINK_MAP = {
    '~/.gitconfig':         'gitconfig',
    '~/.gitignore_global':  'gitignore_global',
    '~/.hammerspoon':       'hammerspoon',
    '~/.psqlrc':            'psqlrc',
    '~/.config/nvim':       'vim',
    '~/.pg_format':         'pg_format.conf',
    '~/.ripgreprc':         'ripgreprc',
    '~/.af-scripts':        'af-scripts',
    '~/.vim':               'vim',
    '~/.vimrc':             'vim/init.vim',
    '~/.tmux.conf':         'tmux.conf',
    '~/.tigrc':             'tigrc',
    '~/.weechat':           'weechat',
    '~/.config/alacritty/alacritty.yml': 'alacritty.yml',
    '~/.zshrc':             'zshrc',
}

# Output a generic header for a section of the install script:
def section(name):
    print('\n' + name)
    print('='*40)

def shell_out(cmd):
    print(subprocess.Popen(cmd, shell=True, stdout=subprocess.PIPE).stdout.read())


# TODO: skip this section if not running macOS
section('Installing homebrew dependencies')
shell_out('./brew_installs.sh')

section('Updating submodules')
shell_out('git submodule update --init && echo Submodules updated!')

section('Installing pip dependencies')
shell_out('pip install --user pynvim')
shell_out('pip3 install --user pynvim')

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
