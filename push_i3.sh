#!/bin/bash

cp -v ~/.i3/config ~/.i3/config_backup
cp -v .i3-config ~/.i3/config
i3-msg restart
