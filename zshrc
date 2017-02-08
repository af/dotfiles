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
DISABLE_AUTO_UPDATE="true"

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
# Note: zsh-syntax-highlighting needs to be cloned to oh-my-zsh's custom/plugins directory first:
plugins=(brew git npm nvm zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

# VI keybindings:
#bindkey -v

bindkey '^k' up-line-or-search
bindkey '^j' down-line-or-search

# Customize to your needs...
PATH="/Applications/Postgres.app/Contents/Versions/latest/bin:$PATH"
export PATH=$(brew --prefix ruby)/bin:$PATH     # For ruby gems
export PATH=/usr/local/bin:$PATH:/usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin:/usr/local/git/bin:/usr/local/heroku/bin:/Users/aaron/.my_scripts:/usr/local/sbin
export PATH=node_modules/.bin:$PATH     # Handy for using locally-installed versions of eslint, etc

export EDITOR=nvim

# Only auto-correct commands (not arguments):
unsetopt correct_all
setopt correct

# Directory traversal:
alias l='ls -alh'
alias ..='cd ..; ls'
alias ...='cd ../..; ls'

# Aliases for git:
alias ci='git commit -v'
alias co='git checkout'
alias cia='git commit -v -a'
alias cim='git commit -v --amend'
alias ciam='git commit -va --amend'
alias ga='git add'
alias gap='git add --patch'
alias gra='git rebase --abort'
alias grc='git rebase --continue'
alias gri='git rebase -i HEAD~10'
alias gs='git status'
alias gsl='git stash list'
alias gss='git stash save'
alias gsp='git stash pop'
alias gl='git log'
alias gc='git checkout'
alias gb='git branch'
alias gdc='git diff --cached'
alias gr='git remote'
alias gpr='git pull --rebase'
alias lat='git latest'
alias t='tig --all'

alias ys='yarn start'
alias yt='yarn test'
alias yl='yarn lint'

# Commonly used tools:
alias v='nvim'
alias vs='nvim -S'
alias p='python'
alias quickweb='python -c "import SimpleHTTPServer as a; a.test()"'
alias pypath='p -c "import sys, pprint; pprint.pprint(sys.path)"'

# Networking
alias httpsniff="sudo ngrep -W byline -d 'en0' -t '^(GET|POST) ' 'tcp and port 80'"
alias slownet="sudo ipfw pipe 1 config bw 100Kbit/s"
alias fastnet="sudo ipfw flush"
# For ipfw info see http://blog.tcs.de/simulate-slow-network-connection-on-mac-os-x/

# NPM & Node:
export NPM_CONFIG_SAVE=true
export NPM_CONFIG_SAVE_EXACT=true
export NPM_CONFIG_LOGLEVEL='warn'
export NPM_CONFIG_INIT_LICENSE='MIT'
export NPM_CONFIG_INIT_AUTHOR_NAME='Aaron Franks'
export NPM_CONFIG_INIT_AUTHOR_URL='http://aaronfranks.com/'
export NODE_PATH=/usr/local/lib/node_modules
ulimit -S -n 5000

# NVM:
source $(brew --prefix nvm)/nvm.sh
export PATH=$(yarn global bin):$PATH       # Add yarn global binaries to PATH

# fasd (https://github.com/clvv/fasd):
eval "$(fasd --init posix-alias zsh-hook)"
alias j='fasd_cd -d'     # jumping to autocompleted directory

# Allow bash-style comments in an interactive shell:
setopt interactivecomments

setopt hist_ignore_all_dups     # Ignore duplicate history items
setopt hist_find_no_dups        # Don't surface duplicates


# Shorthand function to create a new project with a git repo and README:
function af-initproject () {
    mkdir $1
    cd $1
    git init
    touch README.md
    git add README.md
    git commit -m "First commit"
    echo "\nYour new project is ready. Have fun."
}

# Script tmux to set up a window in my (currently) preferred custom layout:
function af-workspace () {
    # Main pane for vim on the left:
    tmux send-keys 'git status' 'C-m'
    tmux splitw -h -p 50

    # tig running in the bottom right:
    tmux splitw -v -p 30
    tmux send-keys 'tig --all' 'C-m'

    tmux select-pane -U
    tmux select-pane -L     # End up on the main (left) pane
}

# Helper to send a command to the right tmux pane.
# Usage: 'ts echo "hello"'
function ts {
    args=$@
    tmux send-keys -t right C-c "$args" C-m
}

# Toggle between zsh and vim with ^z (instead of entering 'fg<CR>' one way)
# source: http://sheerun.net/2014/03/21/how-to-boost-your-vim-productivity/
fancy-ctrl-z () {
    if [[ $#BUFFER -eq 0 ]]; then
        BUFFER="fg"
        zle accept-line
    else
        zle push-input
        zle clear-screen
    fi
}
zle -N fancy-ctrl-z
bindkey '^Z' fancy-ctrl-z

# Command to view man pages using vim.
# Found at https://news.ycombinator.com/item?id=8781621
function m {
v \
-c "source \$VIMRUNTIME/ftplugin/man.vim" \
-c "Man $*" \
-c "set number readonly|only" \
}

# FZF
export FZF_DEFAULT_COMMAND='ag -g "" --hidden --ignore .git'  # Respect .gitignore, show hidden files
# Notes on FZF_DEFAULT_OPTS:
#  * -e is for exact matching
#  * ':' is mapped to "abort", mostly to use with vim.
#  * for a full list of available actions to bind to, see "man fzf" and search for "action"
export FZF_DEFAULT_OPTS='-e --bind ctrl-f:page-down,ctrl-b:page-up,::abort'
export FZF_COMPLETION_OPTS='-m'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"    # Respect .gitignore for ^t
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Automatically accept selected history items from fzf
# Via https://github.com/junegunn/fzf/issues/467#issuecomment-169695942
fzf-history-widget-accept() {
  fzf-history-widget
  zle accept-line
}
zle     -N   fzf-history-widget-accept
bindkey '^R' fzf-history-widget-accept


# Check out git branch with FZF:
b() {
  local branches branch
  #branches=$(git branch -vv) &&        # Old version, via the fzf readme
  # Sort branches by most recently used:
  branches=$(git for-each-ref --sort=-committerdate refs/heads \
                 --format='%(committerdate:short)|%(color:green)%(refname:short)%(color:reset)|%(subject)') &&
  branch=$(echo "$branches" | column -t -s "|" | fzf --ansi +m) &&
  git checkout $(echo "$branch" | awk '{print $2}' | sed "s/.* //")
}

# Check out a git commit with FZF:
fco() {
  local commits commit
  commits=$(git log --pretty=format:"%h %<(15,trunc)%an %s" --reverse) &&
  commit=$(echo "$commits" | fzf --tac +s +m -e) &&
  git checkout $(echo "$commit" | sed "s/ .*//")
}

# Interactive process killing with FZF:
fkill() {
  pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')

  if [ "x$pid" != "x" ]
  then
    kill -${1:-9} $pid
  fi
}

# Android SDK
export ANDROID_HOME=/usr/local/opt/android-sdk

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"
