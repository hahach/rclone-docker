#!/bin/bash

ver=latest 


docker build  \
 -t emile/rclone:${ver}  \
 --build-arg VERSION=${ver}  \
 --force-rm   \
 -f Dockerfile .

docker save -o rclone-${ver}.tar emile/rclone:${ver}

