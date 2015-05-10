#!/usr/bin/env bash

# ANSI colors and prompt style.
source ~/.dotfiles/ansi_colors.sh
source ~/.dotfiles/prompt_style.sh

# Aliases.

function run_gvim() {
    if [ $# -eq 0 ];then
        vim -g --remote-silent .
    else
        vim -g --remote-silent "$@"
    fi
}

alias vi="vim.tiny -u NONE"
alias gvim="run_gvim"
