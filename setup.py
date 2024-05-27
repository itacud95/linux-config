#!/usr/bin/env python3

import os
import argparse


# source_files are relative to this directory
# target_dir is relative to $HOME directory
def create_symlinks(source_files, target_dir):
    home_directory = os.path.expanduser("~")
    target_dir = home_directory + "/" + target_dir
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


def setup_i3():
    source_files = ["i3/config"]
    target_dir = ".config/i3"
    create_symlinks(source_files, target_dir)


def option_2():
    print("You have selected Option 2.")
    # Add logic for Option 2 here


def option_3():
    print("You have selected Option 3.")
    # Add logic for Option 3 here


def main():
    parser = argparse.ArgumentParser(description="Choose one of the available options.")

    group = parser.add_mutually_exclusive_group(required=True)
    group.add_argument("--i3", action="store_true")
    group.add_argument("--option2", action="store_true", help="Select Option 2")
    group.add_argument("--option3", action="store_true", help="Select Option 3")

    args = parser.parse_args()

    if args.i3:
        setup_i3()
    elif args.option2:
        option_2()
    elif args.option3:
        option_3()


if __name__ == "__main__":
    main()
