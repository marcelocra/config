#!/usr/bin/env bash
source ~/.dotfiles/default_bashrc
source ~/.dotfiles/ansi_colors
source ~/.dotfiles/prompt_style

# Source all exports, which must be in ~/.exports file.
source ~/.exports

# Source any system setting not intended for git to track.
source ~/.my_settings

# Previous version that used to work. Trying this new one.
#alias tmux="TERM=screen-256color-bce tmux"
alias tmux="TERM=xterm-256color tmux"
alias ll="ls -la"
alias vi="vim.tiny -u NONE"
alias gvim="vim -g --remote-silent"
alias files="nautilus"
alias sag="sudo apt-get"
alias sagi="sag install"

# Make CapsLock a new Ctrl (use this if you have no system way of doing this).
# setxkbmap -option ctrl:nocaps
