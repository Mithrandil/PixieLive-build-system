#!/bin/bash

test -d /mnt/live/memory/.settings_aufs || exit

. /etc/default/aufs
#includere livekitlib se serve

mount -o remount,udba=fsnotify,shwh /mnt/live/memory/.settings_aufs
mount -o remount,udba=fsnotify /

exclude="$exclude --exclude=/var/tmp"
exclude="$exclude --exclude=/var/run"
exclude="$exclude --exclude=/var/spool"
exclude="$exclude --exclude=/var/lock"
exclude="$exclude --exclude=/var/log"
exclude="$exclude --exclude=/var/cache"
exclude="$exclude --exclude=/var/empty"
exclude="$exclude --exclude=/var/gdm"
exclude="$exclude --exclude=/var/lib/udisks"
exclude="$exclude --exclude=/var/lib/misc/random-seed"
exclude="$exclude --exclude=/etc/fstab"
exclude="$exclude --exclude=/etc/mtab"
exclude="$exclude --exclude=/tmp"
exclude="$exclude --exclude=/dev"
exclude="$exclude --exclude=/proc"
exclude="$exclude --exclude=/sys"
exclude="$exclude --exclude=/media"
exclude="$exclude --exclude=/mnt"
exclude="$exclude --exclude=/run"
exclude="$exclude --exclude=/root"
exclude="$exclude --exclude=.xsession-errors"
exclude="$exclude --exclude=.Xauthority"
exclude="$exclude --exclude=.ICEauthority"
exclude="$exclude --exclude=.dbus"
exclude="$exclude --exclude=.cache"
exclude="$exclude --exclude=.gvfs"
#exclude="$exclude --exclude=.gconfd"
exclude="$exclude --exclude=.thumbnails"
exclude="$exclude --exclude=/lost+found"
exclude="$exclude --exclude=$AUFS_WH_BASE"
exclude="$exclude --exclude=$AUFS_WH_PLINKDIR"
exclude="$exclude --exclude=$AUFS_WH_ORPHDIR"

sync
auplink / flush
rsync --delete-excluded $exclude -aHSxc --devices --specials --delete --delete-before /mnt/live/memory/.settings_aufs/ /mnt/live/memory/changes
sync

mount -o remount,udba=reval,shwh /mnt/live/memory/.settings_aufs
mount -o remount,udba=reval /

echo "Saved!"
