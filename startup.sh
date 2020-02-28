#!/usr/bin/env sh
#
# Commands to be run during startup. Need to figure a way to run them
# automatically.

# Configure hardware.
# ----------------------------------------------------------------------------
[ -z "$MCRA_HARDWARE_CONFIGURED" ] \
  || { echo "Hardware already configured! Skipping."; return 0; }

# Run all commands defined above. They need xinput, so check that first.
command -v xinput >/dev/null 2>&1 \
  || { echo >&2 "I require xinput but it's not installed.  Aborting."; return 1; }

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


setup_expert_mouse
setup_evoluent_mouse
reduce_speed_of_logitech_mouse

export MCRA_HARDWARE_CONFIGURED=true
# ----------------------------------------------------------------------------
