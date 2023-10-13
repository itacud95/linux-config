#!/bin/bash

# [~/.config/sway]   
# ln -s ~/linux-config/sway/config.d/ .
echo 'script is not working'
exit 1

config_dir=~/.config/sway/
config_dir=${config_dir/#\~/$HOME}

script_dir="$(cd "$(dirname "$0")" && pwd)"
source "$script_dir/../symlinker.sh"

symlinker "$config_dir" config.d
