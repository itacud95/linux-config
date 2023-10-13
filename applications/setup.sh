#!/bin/bash

# update
yay

# install packages
yay -S \
speedcrunch \
7-zip-full \
cheese \
ferdium-bin \
flameshot \
keyd \
kitty \
signal-desktop-beta-bin \


# work related
yay -S \
android-apktool \
android-sdk-cmdline-tools-latest \
bundletool \
clang-format-static-bin \
cmake \
slack-desktop \
wireguard-tools \
valgrind \

# argcomplete
yay -S python-argcomplete
sudo activate-global-python-argcomplete --dest /usr/share/bash-completion/completions/
