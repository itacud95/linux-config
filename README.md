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

# yay
Run query: `yay -Q<query>`\
List available queries: `yay -Q --help`\
List explicit installed packages: `yay -Qe`\
List orphaned packages: `yay -Qdt`\
Remove orphaned packages: `yay -Rns $(yay -Qdtq)`

```
yay -Qo /opt/android-sdk/build-tools/34.0.0/zipalign
error: No package owns /opt/android-sdk/build-tools/34.0.0/zipalign

# cmake dependency in android studio
yay -S android-sdk-build-tools

yay -S android-sdk android-studio
cd /opt/android-sdk
sudo chown -R `id -un`:`id -gn` .
```

# pipewire
https://www.maketecheasier.com/install-configure-pipewire-linux/
```
systemctl --user --now disable pulseaudio.service pulseaudio.socket
systemctl --user --now enable pipewire pipewire-pulse pipewire-media-session
```

```
sudo ydotoold &
while true; do sudo ydotool mousemove --absolute $RANDOM $RANDOM; sleep 1; done
```

# code
Running under wayland:
```
cat ~/.config/code-flags.conf
--enable-features=WaylandWindowDecorations
--ozone-platform-hint=auto
```

# audio
Microphone check (to speaker):
```
# route mic to speaker
pactl load-module module-loopback latency_msec=1
# stop
pactl unload-module module-loopback
```
Enable multiprofile for blt headset
https://wiki.archlinux.org/title/bluetooth_headset
```
# edit /etc/bluetooth/main.conf
[General]
MultiProfile=multiple
```