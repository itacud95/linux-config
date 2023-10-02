#!/bin/bash

notify-send 'Patching keyboard'

function exit_msg() {
    notify-send --urgency=critical "${1}"
    exit
}

function disable_caps() {
    caps_lock_status=$(xset -q | sed -n 's/^.*Caps Lock:\s*\(\S*\).*$/\1/p')
    if [ $caps_lock_status == "on" ]; then
        echo "Caps lock on, turning off"
        xdotool key Caps_Lock
    else
        echo "Caps lock already off"
    fi
}

# Reset keymap to US layout
setxkbmap us \
    || exit_msg 'Failed to set US layout'

disable_caps

# Get current keymap
xkbcomp $DISPLAY ~/linux-config/xkeyboard_patcher/original.xkb \
    || exit_msg 'Failed to fetch current keymap'

# Build current patcher
cd ~/linux-config/xkeyboard_patcher \
    || exit_msg 'Failed to enter xkeyboard_pacther directory'
cargo run \
    || exit_msg 'Failed to build rust patcher'
cd -

# Upload modified keymap to server
xkbcomp ~/linux-config/xkeyboard_patcher/output.xkb $DISPLAY \
    || exit_msg 'Failed to upload custom keymap to server'

notify-send 'Keyboard patched'
