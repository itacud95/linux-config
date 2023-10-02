#!/bin/bash

kitty_location='~/.config/kitty/kitty.conf'
kitty_location="${kitty_location/#\~/$HOME}"

# Get the directory containing the script
script_dir="$(cd "$(dirname "$0")" && pwd)"

if [ -f "$kitty_location" ]; then
    echo "Taking backup of existing file"
    timestamp=$(date +%Y%m%d_%H%M%S)
    cp $kitty_location $kitty_location.bak.$timestamp
    rm $kitty_location
fi

ln -s $script_dir/kitty.conf $kitty_location

