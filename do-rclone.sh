#!/bin/sh

rclone move  onedrive:/one /download -P --checkers 4 --transfers 4  --buffer-size 56M  --use-mmap  --config /data/rclone.conf  2>>/data/1.log 

