#!/usr/bin/env bash
source ~/.dotfiles/default_bashrc
source ~/.dotfiles/ansi_colors
source ~/.dotfiles/prompt_style

# Source any system setting not intended for git to track.
source ~/.my_settings

# Previous version that used to work. Trying this new one.
#alias tmux="TERM=screen-256color-bce tmux"
alias tmux="TERM=xterm-256color tmux"
alias ls="ls --color=always"
alias ll="ls -la"
alias l="ls -l"
alias lm="l --block-size=M"
alias lk="l --block-size=K"
alias vi="vim.tiny -u NONE"
alias gvim="vim -g --remote-silent"
alias files="nautilus"
alias sag="sudo apt-get"
alias sagi="sag install"
alias tma="tmux attach"

# Make CapsLock a new Ctrl (use this if you have no system way of doing this).
# setxkbmap -option ctrl:nocaps

# Test for the existance of 'xrdb' command and if it exists, reload the
# ~/.Xresources file.
hash xrdb &> /dev/null && xrdb ~/.Xresources

# Source all exports, which must be in ~/.exports file.
source ~/.exports
