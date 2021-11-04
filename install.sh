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

# echo "comparing chromium configs"
# diff -r $HOME/.config $PWD/.config
# if [ $? -ne 0 ]; then
#     echo "chromium configs are different, creating symlink"
#     rm -r $HOME/.config
#     ln -s gigabot_touchscreen_config/.config/ $HOME/.config
# else
#     echo "chromium .config symlink exists, skipping..."
# fi

BOOT_PATH="/boot"
check_and_overwrite $BOOT_PATH/cmdline.txt $PWD/cmdline.txt
check_and_overwrite $BOOT_PATH/config.txt $PWD/config.txt

LIGHTDM_CONFIG_PATH="/etc/lightdm"
check_and_overwrite $LIGHTDM_CONFIG_PATH/lightdm.conf $PWD/lightdm.conf



