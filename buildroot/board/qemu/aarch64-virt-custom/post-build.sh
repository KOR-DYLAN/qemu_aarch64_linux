#!/bin/bash
# basic environment
QEMU_BOARD_DIR="$(dirname "$0")"
DEFCONFIG_NAME="$(basename "$2")"

# copy /etc/init.d
cp -a  $QEMU_BOARD_DIR/S99automount ${TARGET_DIR}/etc/init.d/

# copy bashrc
mkdir -p ${TARGET_DIR}/mnt/nfs
cp -a $QEMU_BOARD_DIR/.bashrc ${TARGET_DIR}/root/
cp -a $QEMU_BOARD_DIR/.profile ${TARGET_DIR}/root/
cp -a $QEMU_BOARD_DIR/nfs-mount.sh ${TARGET_DIR}/root/
