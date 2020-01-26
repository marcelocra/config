#!/usr/bin/env bash

# Settings.

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

# Exports.
# --------

export PATH="${PATH}:/snap/bin"
export PATH="${PATH}:${HOME}/bin"

# Aliases.
# --------

alias tmux="TERM=xterm-256color tmux"

alias ll="ls -lFa"
alias l="ls -l"

alias vi="vim.tiny -u NONE"

alias inst="sudo apt install"
alias purge="sudo apt purge"

alias eg="egrep"
