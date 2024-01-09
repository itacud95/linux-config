#!/usr/bin/env python3

import os

def list_files_with_extensions(directory, extensions, exclude_directories=[]):
    files = []

    for root, dirs, filenames in os.walk(directory):
        # Exclude specified directories
        dirs[:] = [d for d in dirs if d not in exclude_directories]

        for filename in filenames:
            if any(filename.endswith(ext) for ext in extensions):
                files.append(os.path.join(root, filename))

    return files

# Use the current working directory
directory_to_search = os.getcwd()
file_extensions = ['.txt', '.cmake', '.cpp', 'c', '.h', '.hpp', '.kt', '.java']
directories_to_exclude = ['builddir', 'exclude_dir2']

result_files = list_files_with_extensions(directory_to_search, file_extensions, directories_to_exclude)

for file in result_files:
    print(file)

