#! /bin/bash

#####################################################
# pick first available video device
# change for your needs here!
video_device=$(ls -1 /dev/video*|tail -1)
#
#####################################################

cd $(dirname "$0")

while [ 1 == 1 ]; do
        v4l2-ctl -d "$video_device" -v width=1280,height=720,pixelformat=YV12
        v4l2-ctl -d "$video_device" -p 25
	./toxcam_static -f -d $video_device -2 # > /dev/null 2> /dev/null
	sleep 10
done

