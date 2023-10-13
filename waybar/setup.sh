#!/bin/bash

sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

config_dir=~/.config/waybar/
config_dir=${config_dir/#\~/$HOME}

script_dir="$(cd "$(dirname "$0")" && pwd)"
source "$script_dir/../symlinker.sh"

symlinker "$config_dir" config
