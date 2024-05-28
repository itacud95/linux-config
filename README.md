# linux-config
My linux config files

Set default browser
```
xdg-mime default firefox.desktop x-scheme-handler/https x-scheme-handler/http
```

Notes:
```
font-awesome-5 # fonts needed for default waybar
```

# Yay
```
yay -Qo /opt/android-sdk/build-tools/34.0.0/zipalign
error: No package owns /opt/android-sdk/build-tools/34.0.0/zipalign

# cmake dependency in android studio
yay -S android-sdk-build-tools

yay -S android-sdk android-studio
cd /opt/android-sdk
sudo chown -R `id -un`:`id -gn` .
```
Remove orphaned packages
```
yay -Qdt
yay -Rns $(yay -Qdtq)
```

# Pipewire
https://www.maketecheasier.com/install-configure-pipewire-linux/
```
systemctl --user --now disable pulseaudio.service pulseaudio.socket
systemctl --user --now enable pipewire pipewire-pulse pipewire-media-session
```

```
sudo ydotoold &
while true; do sudo ydotool mousemove --absolute $RANDOM $RANDOM; sleep 1; done
```

