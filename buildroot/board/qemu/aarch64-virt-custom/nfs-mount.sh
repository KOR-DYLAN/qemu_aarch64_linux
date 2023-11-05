#!/bin/bash
GATEWAY_IP=$(route | grep '^default' | awk '{print $2}')
MOUNTPOINT=/mnt/nfs
NFSROOT=/nfsroot

echo "mount -t nfs -o nolock $GATEWAY_IP:$NFSROOT $MOUNTPOINT"
mount -t nfs -o nolock $GATEWAY_IP:$NFSROOT $MOUNTPOINT
