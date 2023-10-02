#!/bin/bash

vscode_config_dir='~/.config/Code/User'

files=(
    "keybindings.json"
    "launch.json"
    "settings.json"
)

create_symlink_for() {
    path="$1"
    # Expand ~ to the home directory
    path="${path/#\~/$HOME}"

    echo "creating symlink for $path"

    if [ ! -d "$path" ]; then
        echo "directory '$path' does not exist, skipping. "
        return
    fi

    # cd $path

    for file in "${files[@]}"; do
        target=$path/$file
        echo "***target: $target"
        
        if [ -f "$target" ]; then
            echo "Taking backup of existing file"
            cp $target $target.bak
            rm $target
        fi
        ln -s ~/linux-config/code/$file $target
    done
}

create_symlink_for $vscode_config_dir
