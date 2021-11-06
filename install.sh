#!/bin/bash 

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
# Boot cmdline setup
check_and_overwrite $BOOT_PATH/cmdline.txt $PWD/cmdline.txt
# Display KMS setup
check_and_overwrite $BOOT_PATH/config.txt $PWD/config.txt
check_and_overwrite $BOOT_PATH/fullpageos.txt $PWD/fullpageos.txt
check_and_overwrite $BOOT_PATH/splash.png $PWD/splash.png

LIGHTDM_CONFIG_PATH="/etc/lightdm"
# Enable xrandr script on boot
check_and_overwrite $LIGHTDM_CONFIG_PATH/lightdm.conf $PWD/lightdm.conf
# Disable Cursor
check_and_overwrite "/usr/share/lightdm/lightdm.conf.d/01_debian.conf" $PWD/01_debian.conf

apt-get install xinput -y
FULLPAGEOS_SCRIPT_PATH="$HOME/scripts"
check_and_overwrite $FULLPAGEOS_SCRIPT_PATH/start_chromium_browser $PWD/start_chromium_browser


# TODO: Debug enabling keyboard extension
# echo "comparing chromium configs"
# diff -r $HOME/.config $PWD/.config
# if [ $? -ne 0 ]; then
#     echo "chromium configs are different, creating symlink"
#     rm -r $HOME/.config
#     ln -s gigabot_touchscreen_config/.config/ $HOME/.config
# else
#     echo "chromium .config symlink exists, skipping..."
# fi

# Fluidd + Moonraker + Klipper Installation 
cd $HOME && git clone https://github.com/th33xitus/kiauh.git
