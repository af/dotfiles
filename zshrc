# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="alanpeabody"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment to change how often before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want to disable command autocorrection
# DISABLE_CORRECTION="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Uncomment following line if you want to disable marking untracked files under
# VCS as dirty. This makes repository status check for large repositories much,
# much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git)

source $ZSH/oh-my-zsh.sh

# VI keybindings:
#bindkey -v

# Customize to your needs...
PATH="/Applications/Postgres.app/Contents/MacOS/bin:$PATH"
export PATH=$PATH:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/opt/X11/bin:/usr/local/git/bin:/usr/local/heroku/bin:/Users/aaron/.my_scripts:/usr/local/sbin

# Directory traversal:
alias l='ls -alh'
alias ..='cd ..; ls'
alias ...='cd ../..; ls'

# Aliases for git:
alias gs='git status'
alias gl='git log'
alias gc='git checkout'
alias gb='git branch'
alias gr='git remote'

# Commonly used tools:
alias p='python'
alias quickweb='python -c "import SimpleHTTPServer as a; a.test()"'
alias pypath='p -c "import sys, pprint; pprint.pprint(sys.path)"'

# Networking
alias httpsniff="sudo ngrep -W byline -d 'en0' -t '^(GET|POST) ' 'tcp and port 80'"
alias slownet="sudo ipfw pipe 1 config bw 100Kbit/s"
alias fastnet="sudo ipfw flush"
# For ipfw info see http://blog.tcs.de/simulate-slow-network-connection-on-mac-os-x/

# Reelhouse:
source $HOME/code/reelhouse/reelhouse_init.sh
export NODE_PATH=/usr/local/lib/node_modules

# NVM:
source ~/.nvm/nvm.sh

# Allow bash-style comments in an interactive shell:
setopt interactivecomments

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

