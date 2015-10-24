#!/usr/bin/env bash
source ~/.dotfiles/default_bashrc
source ~/.dotfiles/ansi_colors
source ~/.dotfiles/prompt_style

# Source all exports, which must be in ~/.exports file.
source ~/.exports

alias tmux="TERM=screen-256color-bce tmux"
alias ll="ls -la"
alias vi="vim.tiny -u NONE"
alias vim="vim"
alias gvim="vim -g --remote-silent"

# Make CapsLock a new Ctrl (use this if you have no system way of doing this).
# setxkbmap -option ctrl:nocaps

