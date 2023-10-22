#!/bin/bash
echo "installing samba..."
sudo apt-get install samba -y
echo sudo smbpasswd -a $USER
sudo smbpasswd -a $USER
sudo test -e "/etc/samba/smb.conf" && sudo cp /etc/samba/smb.conf /etc/samba/smb.conf_backup
echo -e "
[linux-server-$USER]
comment = $USER' shared directory
path = /
read only = no
writable = yes
guest ok = no
browsable = yes
valid user = $USER
create mask = 0644
directory mask = 0644" | sudo tee -a /etc/samba/smb.conf > /dev/null