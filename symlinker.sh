#!/bin/bash

script_dir="$(cd "$(dirname "$0")" && pwd)"
echo "$script_dir"

# Usage:
# symlinker config_dir source_files
symlinker() {
    if [ $# -lt 2 ]; then
        echo "Usage: symlinker source target1 target2"
        return 1
    fi
    
    config_dir="$1"
    # next argument
    shift
    
    echo "config dir: $config_dir"
    if [ ! -d "$config_dir" ]; then
        mkdir -p "$config_dir"
        echo "created directory: $config_dir"
    fi
    
    while [ $# -gt 0 ]; do
        
        target="$1"
        target_path=$config_dir$target
        source_path=$script_dir/$target
        
        echo "***Creating symlink from '$source_path' to '$target_path'"
        
        if [ -h "$target_path" ] && [ ! -e "$target_path" ]; then
            echo "Removing dead symlink: $target_path"
            rm "$target_path"
        fi
        
        if [ -f "$target_path" ]; then
            echo "Taking backup of $target_path"
            timestamp=$(date +%Y%m%d_%H%M%S)
            cp "$target_path" "${target_path}.bak.$timestamp"
            rm "$target_path"
        fi
        
        ln -s "$source_path" "$target_path"
        shift
    done
}

