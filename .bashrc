#!/usr/bin/env bash

export PATH=$PATH:$HOME/.bin

alias tmux="TERM=screen-256color-bce tmux"
alias ll="ls -la"

source ~/.dotfiles/ansi_colors.sh
source ~/.dotfiles/prompt_style.sh

alias vi="vim.tiny -u NONE"
alias vim="vim"
alias gvim="vim -g --remote-silent"

# Make CapsLock a new Ctrl (use this if you have no system way of doing this).
# setxkbmap -option ctrl:nocaps

