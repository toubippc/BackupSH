#!/bin/bash


if [ "root" != $USER ]
then
	echo "This script must be executed with sudo/root rights";
	exit 0;
fi

./sxsync.sh antesync it 192.168.1.210 /srv /media/DATA/dev/ 22 /home/it/.ssh/itluxus 2> rsync_error.log
