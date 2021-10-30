
read -sp "pi password: " pass

echo
#Remove side scroll bar
sshpass -p "$pass" scp start_chromium_browser pi@192.168.1.$1:~/scripts/
#Install keyboard plugin
sshpass -p "$pass" scp -r ./.config pi@192.168.1.$1:~/

#Enable kms
#sshpass -p "$pass" scp -r config.txt pi@192.168.1.$1:/boot/

#Remove cursor
#sshpass -p "$pass" scp 01_debian.conf pi@192.168.1.$1:/usr/share/lightdm/lightdm.conf.d



