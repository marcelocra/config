#!/usr/bin/env zsh

# Settings.
# ---------

# Configure expert mouse, if available.
setup_expert_mouse() {
    local device_id

    device_id=$(xinput list \
        | sed -nre 's/.*Kensington\ Expert\ Mouse.*id\=([0-9]+).*/\1/p' \
        | head -n1)
    if [ ! -z "$device_id" ]; then
        xinput set-button-map $device_id 8 1 3 4 5 6 7 9 0 0
    fi
}
setup_expert_mouse

# Configure Evoluent vertical mouse so that back/forward buttons work as
# expected.
setup_evoluent_mouse() {
    local device_id

    device_id=$(xinput \
        | sed -nre 's/.*Evoluent\ VerticalMouse.*id\=([0-9]+).*/\1/p' \
        | head -n1)
    if [ ! -z "$device_id" ]; then
        xinput set-button-map $device_id 1 2 3 4 5 6 7 8 10 9
    fi
}
setup_evoluent_mouse

reduce_speed_of_logitech_mouse() {
    local device_id
    device_id=$(xinput \
        | sed -nre 's/.*Logitech.*Mouse.*id\=([0-9]+).*/\1/p' \
        | head -n1)
    if [ -z "$device_id" ]; then
        return
    fi

    local prop_id
    prop_id=$(xinput list-props $device_id \
        | sed -nre 's/.*Accel\ Speed\ \(([0-9]+)\).*/\1/p' \
        | head -n1)
    if [ -z "$prop_id" ]; then
        return
    fi

    xinput set-prop $device_id $prop_id -0.75  # I found this value to be good.
}
reduce_speed_of_logitech_mouse

tmx() {
    # Try to create a new session.
    tmux new -s $1 > /dev/null 2>&1
    if [ $? -eq 0 ]; then
        return 0
    fi

    echo "Trying to reuse session $1..."
    sleep 0.5
    # Try to load existing session.
    tmux attach-session -t $1 > /dev/null 2>&1
    if [ $? -eq 0 ]; then
        return 0
    fi

    # Something else happened.
    echo "An error happened. Couldn't load $1"
    return 1
}

# Exports.
# --------
# Add a number of paths to PATH.

# Snapcraft.
if [ -d "/snap/bin" ] ; then
    export PATH="${PATH}:/snap/bin"
fi

# My binaries.
if [ -d "$HOME/bin" ] ; then
    export PATH="${PATH}:${HOME}/bin"
fi

# Private binaries (and also pip3 package dir).
if [ -d "$HOME/.local/bin" ] ; then
    export PATH="$HOME/.local/bin:$PATH"
fi

# Node stuff.
#
# NVM should be loaded first, as other exports and commands will need a
# valid Node installation.
if [ -d "$HOME/.nvm" ]; then
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
fi

# Yarn global binaries.
if [ -d "$HOME/.config/yarn/global" ] ; then
    export PATH="${PATH}:`yarn global bin`"
fi

# Aliases.
# --------

alias tmux="TERM=xterm-256color tmux"

alias vi="vim.tiny -u NONE"

alias inst="sudo apt install"
alias purge="sudo apt purge"

alias eg=egrep

alias pip=pip3
alias python=python3

alias l="ls -lFh"
alias ll="ls -lFha"

alias szsh="source ${HOME}/.zshrc"
alias sbash="source ${HOME}/.bashrc"

# Other scripts.
# --------------

# Install fzf.
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh