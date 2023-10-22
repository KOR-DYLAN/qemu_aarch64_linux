#!/bin/bash
NFS_DIR=/nfsroot

echo "configuring nfs..."
sudo mkdir -p $NFS_DIR
sudo chown $USER:$USER $NFS_DIR
sudo apt install nfs-kernel-server -y
sudo test -e "/etc/exports" && sudo cp /etc/exports /etc/exports_backup
sudo echo "$NFS_DIR *(rw,sync,no_root_squash,no_subtree_check)" | sudo tee -a /etc/exports > /dev/null
sudo service nfs-kernel-server restart