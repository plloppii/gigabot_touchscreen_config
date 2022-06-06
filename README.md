# Gigabot Touchscreen
The Gigabot Touchscreen is built ontop of [FullPageOS](https://github.com/guysoft/FullPageOS)
This CustomPiOS is a Raspbian image that displays a chromium webpage in full screen mode. 

This repository is used to install additional OS dependencies and repositories to install the Klipper software stack ontop of FullPageOS.

## Installation

1. Flash a SD card with FullPageOS using a image flasher such as the [Raspberry Pi Imager](https://www.raspberrypi.com/software/)
2. Input the flashed image into a raspberry pi, and ssh into the pi
3. Run ```git clone https://github.com/re3Dprinting/gigabot_touchscreen_config```
4. Run ```sudo ./gigabot_touchscreen_config/install.sh```. Wait for the installation to finish
5. Once the installation finishes, you should be able to plug in the re3D Touchscreen and pull up the Mainsail interface

## More Details
As stated above, there are many Fullpageos_modifications specific to getting the raspberry pi to display its interface on the HMTech Display.

apt-get Dependencies ontop of FullpageOS:

```xinput ripgrep nmap```

Other system level configurations are as

### Disable Scrollbar
Add ``` --enable-features=OverlayScrollbar ``` to starting chromium script, ```~/scripts/start_chromium_browser```

### Disable Cursor
Append ```xserver-command=X -nocursor``` to ```/usr/share/lightdm/lightdm.conf.d/01_debian.conf```

### Add Keyboard Extension to Chromium
Copy ```.config ``` to home directory of pi

### Enable full kms graphics driver
Append ```dtoverlay=vc4-kms-v3d``` to ```/boot/config.txt```

### Adjust screen resolution permenantly
Upload ```xrandr/``` script file, and add ```lightdm.conf``` to ```/etc/lightdm/lightdm.conf```
Move ```lightdm.conf``` to ```/etc/lightdm/```

### Allow for screen rotations
Install xinput with ```sudo apt install xinput```
enable full kms driver, and run ```~/scripts/rotate.sh left```

### Disable boot text 
Upload ```cmdline.txt``` to ```/boot/```

### Troubleshooting
Get lightdm service status ```journalctl -u lightdm.service```

### Recording with autoexpect
```autoexpect -p ./kiauh/kiauh.sh```

### Installation
Clone the repo onto a base image of FullPageOs
```git clone https://github.com/plloppii/gigabot_touchscreen_config ```
Run the install script
```./gigabot_touchscreen_config/install.sh```
