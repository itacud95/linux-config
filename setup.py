#!/usr/bin/env python3

import os


def create_symlinks(source_files, target_dir):
    if not os.path.exists(target_dir):
        raise Exception(f"{target_dir} does not exist")

    for source_file in source_files:

        if not os.path.exists(source_file):
            raise Exception(f"{source_file} does not exist")

        source_path = os.path.abspath(source_file)
        source_file_name = os.path.basename(source_path)
        target_path = os.path.join(target_dir, source_file_name)

        print(f"symlinker src: {source_path} -> dst: {target_path}")

        if os.path.exists(target_path) or os.path.islink(target_path):
            overwrite = (
                input(f"File {target_path} already exists. Overwrite? (y/n): ")
                .strip()
                .lower()
            )
            if overwrite != "y":
                print(f"Skipping {source_path}.")
                continue

            os.remove(target_path)

        os.symlink(source_path, target_path)
        print(f"Created symlink for {source_path}.")


# Example usage:
source_files = ["i3/config"]
target_dir = "/home/jk/linux-config/testdir"
create_symlinks(source_files, target_dir)
