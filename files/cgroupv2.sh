#!/bin/sh
set -e

# Ensure we're root
[ "$(id -u)" -ne 0 ] && echo "Run as root" && exit 1

# Remount /data with dev and suid if needed
mount -o remount,dev,suid /data || echo "Failed to remount /data"

# Create cgroup2 mount point if not present
mkdir -p /sys/fs/cgroup

# Check if cgroup2 already mounted
if ! mountpoint -q /sys/fs/cgroup; then
    mount -t cgroup2 none /sys/fs/cgroup && echo "Mounted cgroup v2"
else
    echo "/sys/fs/cgroup is already mounted"
fi
