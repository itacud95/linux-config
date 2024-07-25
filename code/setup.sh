#!/bin/bash

config_dir="~/.config/Code - OSS/User/"

config_dir=${config_dir/#\~/$HOME}

script_dir="$(cd "$(dirname "$0")" && pwd)"
source "$script_dir/../symlinker.sh"

symlinker "$config_dir" keybindings.json launch.json settings.json
