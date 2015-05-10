#!/usr/bin/env bash

# ANSI colors and prompt style.
source ~/.dotfiles/ansi_colors.sh
source ~/.dotfiles/prompt_style.sh

# Aliases.

## Vim.
function run_gvim() {
    if [ $# -eq 0 ];then
        vim -g --remote-silent .
    else
        vim -g --remote-silent "$@"
    fi
}

alias vi="vim.tiny -u NONE"
alias vim="vim"
alias gvim="run_gvim"

## Git.
alias gb="git branch"
alias gco="git checkout"
alias gd="git diff"
alias gs="git status"
