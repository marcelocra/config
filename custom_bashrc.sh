#!/usr/bin/env bash

# --------------------
# ANSI color codes
# --------------------

RS="\[\033[0m\]"    # reset
HC="\[\033[1m\]"    # hicolor
UL="\[\033[4m\]"    # underline
INV="\[\033[7m\]"   # inverse background and foreground
FBLK="\[\033[30m\]" # foreground black
FRED="\[\033[31m\]" # foreground red
FGRN="\[\033[32m\]" # foreground green
FYEL="\[\033[33m\]" # foreground yellow
FBLE="\[\033[34m\]" # foreground blue
FMAG="\[\033[35m\]" # foreground magenta
FCYN="\[\033[36m\]" # foreground cyan
FWHT="\[\033[37m\]" # foreground white
BBLK="\[\033[40m\]" # background black
BRED="\[\033[41m\]" # background red
BGRN="\[\033[42m\]" # background green
BYEL="\[\033[43m\]" # background yellow
BBLE="\[\033[44m\]" # background blue
BMAG="\[\033[45m\]" # background magenta
BCYN="\[\033[46m\]" # background cyan
BWHT="\[\033[47m\]" # background white

# --------------------
# Setup the prompt
# --------------------

get_git_branch() {
    local branch

    if branch=$(git rev-parse --abbrev-ref HEAD 2> /dev/null); then
        if [[ "$branch" == "HEAD" ]]; then
            branch='detached*'
        fi
    else
        # Not in a git repository. Show nothing.
        echo ''
        return
    fi
    echo "$branch"
}

set_bash_prompt() {
    # Grab the return code of the last ran command.
    local ret_code="$?"
    local git_branch="$(get_git_branch)"

    if [ "${git_branch}" != "" ]; then
        git_branch="($git_branch)"
    else
        git_branch=""
    fi

    if [ $ret_code -eq 0 ]; then
        PS1="$FGRN"
    else
        PS1="$FRED"
    fi

    # 21 is the size of the date and time shown in the separator line.
    for i in $(seq 1 $((COLUMNS-21))); do
        PS1="$PS1-"
    done
    PS1="$PS1[\D{%F %T}]"
    # Reset prompt color.
    PS1="$PS1$RS"

    local prompt_char
    local user_host
    local working_dir

    prompt_char="$RS$HC$FCYN$"
    user_host="$USER@$HOSTNAME"
    working_dir="[\w]"

    # Prompt first line.
    PS1="$PS1$user_host $working_dir $git_branch\n"
    # Prompt second line.
    PS1="$PS1$prompt_char$RS "
}

simple_prompt () {
    local return_code="$?"
    local time_len=8  # 00:00:00
    local date_len=10  # 2000/01/01
    local num_spaces=$(( COLUMNS - time_len - date_len - ${#USER} - \
        ${#HOSTNAME} - 1 ))  # `1` for the `@` sign at user@host.
    local initial_spaces=$(( (num_spaces / 2) - 1 ))
    local remaining_spaces=$(( num_spaces - initial_spaces ))

    PS1="$BWHT"

    if [ $return_code -ne 0 ]; then
        PS1="$BRED"
    fi

    PS1="$FBLK$PS1\D{%F}"
    for i in $(seq $initial_spaces); do
        PS1="$PS1 "
    done
    PS1="$PS1\u@$HOSTNAME"
    for i in $(seq $remaining_spaces); do
        PS1="$PS1 "
    done
    PS1="$PS1\D{%T}$RS\n[\w]\n$ "
}

PROMPT_COMMAND="simple_prompt"

# --------------------------------
# Create a bunch of new aliases
# --------------------------------

# Previous version that used to work. Trying this new one.
#alias tmux="TERM=screen-256color-bce tmux"
alias tmux="TERM=xterm-256color tmux"
alias ll="ls -lFa"
alias l="ls -l"
alias vi="vim.tiny -u NONE"
alias gvim="vim -g --remote-silent"
alias files="nautilus"
alias sag="sudo apt-get"
alias sagi="sag install"
alias tma="tmux attach"

# ----------------------------
# Commands to improve setup
# ----------------------------

# Make CapsLock a new Ctrl (use this if you have no system way of doing this).
# setxkbmap -option ctrl:nocaps

# Test for the existance of 'xrdb' command and if it exists, reload the
# ~/.Xresources file.
hash xrdb &> /dev/null && xrdb ~/.Xresources
