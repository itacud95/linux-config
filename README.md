# linux-config
My linux config files

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
