Fullpageos_modifications to get running on HMTech Display with fluidd
Fullpage OS uses Lightdm (Light Display Manager)

## Disable Scrollbar
Add ``` --enable-features=OverlayScrollbar ``` to starting chromium script, ```~/scripts/start_chromium_browser```

### Disable Cursor
Append ```xserver-command=X -nocursor``` to ```/usr/share/lightdm/lightdm.conf.d/01_debian.conf```

## Add Keyboard Extension to Chromium
Copy ```.config ``` to home directory of pi

## Enable full kms graphics driver
Append ```dtoverlay=vc4-kms-v3d``` to ```/boot/config.txt```

## Adjust screen resolution permenantly
Upload ```xrandr/``` script file, and add ```lightdm.conf``` to ```/etc/lightdm/lightdm.conf```
Move ```lightdm.conf``` to ```/etc/lightdm/```

## Allow for screen rotations
Install xinput with ```sudo apt install xinput```
enable full kms driver, and run ```~/scripts/rotate.sh left```

## Disable boot text 
Upload ```cmdline.txt``` to ```/boot/```

## Troubleshooting
Get lightdm service status ```journalctl -u lightdm.service```