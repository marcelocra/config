#!/usr/bin/env bash

# ANSI colors and prompt style.
source ~/.dotfiles/ansi_colors.sh
source ~/.dotfiles/prompt_style.sh

############################
##### Aliases.
############################

alias vi="vim.tiny -u NONE"
alias vim="vim"
alias gvim="vim -g --remote-silent"

# Git.
alias gb="git branch"
alias gco="git checkout"
alias gd="git diff"
alias gl="git log"
alias gs="git status"

# Better way to print files
alias t="tree -L 1"
alias tl="tree -L"

# Allow proper coloring while using tmux
#alias tmux="tmux"
alias tmux="TERM=screen-256color-bce tmux"
#alias tmux="TERM=screen-256color-bce; tmux -2"
#alias tmux="tmux -2"

############################
##### Settings.
############################

# Make CapsLock a new Ctrl.
setxkbmap -option ctrl:nocaps

############################
##### Environment.
############################

# Add Google AppEngine to PATH.
export PATH="$HOME/Development/Tools/google_appengine:$PATH"

# Add Leiningen.
export PATH="$PATH:$HOME/Development/Tools/lein/"
