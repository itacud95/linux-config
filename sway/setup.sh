#!/bin/bash

# write device config picked
file="$HOME/linux-config/sway/device_config/device_config"
content="# include $HOME/linux-config/sway/device_config/laptop.config"
if [ ! -f "$file" ]; then
    echo "$content" > "$file"
    echo "File created and string written."
else
    echo "File already exists. No changes made."
fi

# [~/.config/sway]   
# ln -s ~/linux-config/sway/config.d/ .
echo 'script is not working'
exit 1

config_dir=~/.config/sway/
config_dir=${config_dir/#\~/$HOME}

script_dir="$(cd "$(dirname "$0")" && pwd)"
source "$script_dir/../symlinker.sh"

symlinker "$config_dir" config.d
