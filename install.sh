#!/bin/bash 

usage() {
  cat << EOF # remove the space between << and EOF, this is due to web plugin issue
Usage: $(basename "${BASH_SOURCE[0]}") [bedsize]

Enter 1-4 Depending on size of bot you are installing on
    1) Regular
    2) XLT
    3) Terabot
    4) Exabot
EOF
  exit
}

if [ -z "$1" ]
then
	usage
fi

PWD="$(cd "$(dirname "$0")" && pwd)"
HOME=$PWD/..

function check_and_overwrite {
    overwrite_file=$1
    new_file=$2 
    if cmp $new_file $overwrite_file; then
        echo "$new_file and $overwrite_file are the same, skipping..."
    else
        echo "overwriting $overwrite_file"
        cp $new_file $overwrite_file
    fi
}

# System Setup

BOOT_PATH="/boot"
# Display KMS setup
check_and_overwrite $BOOT_PATH/config.txt $PWD/config.txt
check_and_overwrite $BOOT_PATH/fullpageos.txt $PWD/fullpageos.txt
check_and_overwrite $BOOT_PATH/splash.png $PWD/splash.png
#Stop logging over serial
sed -i "s/console=serial0,115200//g" $BOOT_PATH/cmdline.txt 

LIGHTDM_CONFIG_PATH="/etc/lightdm"
# Enable xrandr script on boot
check_and_overwrite $LIGHTDM_CONFIG_PATH/lightdm.conf $PWD/lightdm.conf
# Disable Cursor
check_and_overwrite "/usr/share/lightdm/lightdm.conf.d/01_debian.conf" $PWD/01_debian.conf

apt-get install xinput -y
FULLPAGEOS_SCRIPT_PATH="$HOME/scripts"
check_and_overwrite $FULLPAGEOS_SCRIPT_PATH/start_chromium_browser $PWD/start_chromium_browser

# Fluidd + Moonraker + Klipper Installation 

sudo -i -u pi bash << EOF
whoami
cd $HOME
if [ ! -d "$HOME/kiauh" ] ; then
    git clone https://github.com/plloppii/kiauh.git
fi
if [ ! -d "$HOME/virtual_keyboard" ] ; then
    git clone https://github.com/plloppii/virtual_keyboard.git
fi
if [ ! -d "$HOME/klipper_config" ] ; then
    git clone https://github.com/plloppii/klipper_config.git
fi

cd $HOME/klipper_config && ./setup_printer.sh 1

cd $PWD
./install_klipper.exp
./install_moonraker.exp
./install_mainsail.exp
EOF

# ssh into pi
# Enable plugin by going to new chromium tab, and enabling dev mode and add unpacked extension