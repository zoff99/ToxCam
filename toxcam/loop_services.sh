#! /bin/bash

cd $(dirname "$0")

while [ 1 == 1 ]; do
    #####################################################
    # pick first available video device
    # change for your needs here!
    video_device=$(ls -1 /dev/video*|tail -1)
    #
    #####################################################

    v4l2-ctl -d "$video_device" -v width=1280,height=720,pixelformat=YV12
    # v4l2-ctl -d "$video_device" -v width=640,height=480,pixelformat=YV12
    v4l2-ctl -d "$video_device" -p 30

    prog="./toxcam"
    if [ -e ./toxcam_static ]; then
        prog="./toxcam_static"
    fi
    chmod u+x "$prog"

	"$prog" -f -d $video_device -2 -b 600 -q 60 # > /dev/null 2> /dev/null
	sleep 10
done

