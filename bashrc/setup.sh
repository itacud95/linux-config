#!/bin/bash

bashrc_location='~/.bashrc'
bashrc_location="${bashrc_location/#\~/$HOME}"

# Get the directory containing the script
script_dir="$(cd "$(dirname "$0")" && pwd)"

if [ -f "$bashrc_location" ]; then
    echo "Taking backup of existing file"
    timestamp=$(date +%Y%m%d_%H%M%S)
    cp $bashrc_location $bashrc_location.bak.$timestamp
    rm $bashrc_location
fi

ln -s $script_dir/.bashrc $bashrc_location

