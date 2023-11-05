#!/bin/bash
echo 0 > /sys/kernel/debug/tracing/tracing_on
echo "ftrace off"
sleep 3
cp /sys/kernel/debug/tracing/trace /mnt/nfs/
mv /mnt/nfs/trace /mnt/nfs/ftrace_log.c
chown nobody:nobody /mnt/nfs/ftrace_log.c
