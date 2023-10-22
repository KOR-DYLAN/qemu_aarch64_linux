#!/bin/bash
TFTP_DIR=/tftpboot

echo "configuring tftp..."
sudo mkdir -p $TFTP_DIR
sudo chown $USER:$USER $TFTP_DIR
sudo apt install tftp tftpd xinetd -y
sudo test -e "/etc/xinetd.d/tftp" && sudo cp /etc/xinetd.d/tftp /etc/xinetd.d/tftp_backup
echo -e "service tftp
{
	socket_type = dgram
	protocol = udp
	wait = yes
	user = $USER
	server = /usr/sbin/in.tftpd
	server_args = -s $TFTP_DIR
	disable = no
	per_source = 11
	cps = 100 2
	flags =IPv4
}" | sudo tee -a /etc/xinetd.d/tftp > /dev/null
sudo service xinetd restart