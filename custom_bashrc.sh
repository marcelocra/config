#!/usr/bin/env bash

#-------------------------------------------------------------------------------
# Prompt colors.
#-------------------------------------------------------------------------------

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

#-------------------------------------------------------------------------------
# Functions.
#-------------------------------------------------------------------------------

function get_git_branch() {
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

function set_bash_prompt() {
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

function simple_prompt () {
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

function docker_clean_all () {
    docker stop $(docker ps -aq) && docker rm $(docker ps -aq)
}

#-------------------------------------------------------------------------------
# Aliases.
#-------------------------------------------------------------------------------

# Tmux stuff.
# Previous version that used to work.
#alias tmux="TERM=screen-256color-bce tmux"
# New version, that is currently working.
alias tmux="TERM=xterm-256color tmux"
alias tma="tmux attach"

# File stuff.
alias ll="ls -lFa"
alias l="ls -l"
alias files="nautilus"
alias trash="gvfs-trash"

# Vim stuff.
alias vi="vim.tiny -u NONE"
alias gvim="vim -g --remote-silent"

# Install stuff.
alias sag="sudo apt-get"
alias sagi="sag install"

# Docker.
alias di="docker images --format \"{{.Repository}}:{{.Tag}} -> {{.Size}}\""

#-------------------------------------------------------------------------------
# Commands to improve setup.
#-------------------------------------------------------------------------------

# Run the given function before generating the prompt.
PROMPT_COMMAND="simple_prompt"

# Make CapsLock a new Ctrl (use this if you have no system way of doing this).
# setxkbmap -option ctrl:nocaps

# Test for the existance of 'xrdb' command and if it exists, reload the
# ~/.Xresources file.
hash xrdb &> /dev/null && xrdb ~/.Xresources

# If xinput is installed, change the sensitivity for some of the input methods.
# Note that the values of the properties are set for this system in particular.
# They might be different in another system.
if hash xinput 2>/dev/null; then
    # Check if touchpad is available and try to increase its sensitivity,
    # failing quietly.
    if udevadm info --export-db | grep ID_INPUT_TOUCHPAD=1 &>/dev/null; then
        # Find the id of the device that controls the touchpad. Here, where I
        # set 'TouchPad', must be the unique part of your device name that can
        # be used to find its id.
        device_id=$(xinput | sed -n 's/^.*TouchPad.*id=\([0-9]*\).*/\1/p')
        # Find the id of the property that controls device deceleration.
        prop_id=$(xinput list-props $device_id | sed -n -r 's/^.*Device Accel Constant Deceleration \(([0-9]+)\).*/\1/p')
        # Set the property. Choose the value that most suit you.
        xinput set-prop $device_id $prop_id 8.0 &>/dev/null
    fi

    # Check if mouse is available and try to increase its sensitivity, failing
    # quietly.
    if udevadm info --export-db | grep ID_INPUT_MOUSE=1 &>/dev/null; then
        # For explanation about what the commands are doing, check the version
        # above.
        device_id=$(xinput | sed -r -n 's/^.*Logitech.*M325.*id=([0-9]+).*/\1/p')
        prop_id=$(xinput list-props $device_id | sed -n -r 's/^.*Device Accel Constant Deceleration \(([0-9]+)\).*/\1/p')
        xinput set-prop $device_id $prop_id 3.0 &>/dev/null
    fi
fi
