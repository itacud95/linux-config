#!/bin/bash

i3_config='~/.config/i3/config'
i3_config="${i3_config/#\~/$HOME}"

# Get the directory containing the script
script_dir="$(cd "$(dirname "$0")" && pwd)"

if [ -f "$i3_config" ]; then
    echo "Taking backup of existing file"
    timestamp=$(date +%Y%m%d_%H%M%S)
    cp $i3_config $i3_config.bak.$timestamp
    rm $i3_config
fi

ln -s $script_dir/config $i3_config
