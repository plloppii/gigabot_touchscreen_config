#!/bin/bash

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

apt-get install usbmount

# Set up the scripts that configure the 'usbmount' package, which will
# mount any recognized filesystem when a USB thumb drive is inserted.
cp usb/usbmount.conf /etc/usbmount/usbmount.conf
cp usb/00_create_model_symlink /etc/usbmount/mount.d/
cp usb/00_remove_model_symlink /etc/usbmount/umount.d/

chown root:root /etc/usbmount/mount.d/00_create_model_symlink
chown root:root /etc/usbmount/umount.d/00_remove_model_symlink 

chown 755 /etc/usbmount/mount.d/00_create_model_symlink
chmod 755 /etc/usbmount/umount.d/00_remove_model_symlink
chmod 644 /etc/usbmount/usbmount.conf

#Set PrivateMount to No in systemd-udevd.service
cp usb/systemd-udevd.service /lib/systemd/system/systemd-udevd.service
chmod 644 /lib/systemd/system/systemd-udevd.service

# Make the directory we're going to use to contain symbolic links to
# mounted thumb drives.
mkdir /usb
chown root:root /usb