#!/bin/sh

num=$(ps -a|grep flock|grep -v grep|wc -l)

if [ "$num" -eq 1 ]
	then
	flock -x /tmp/down.lock -c "sh /bin/do-rclone.sh"
else
	flock -xn /tmp/down.lock -c "sh /bin/do-rclone.sh"
fi
