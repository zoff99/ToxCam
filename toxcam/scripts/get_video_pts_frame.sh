#! /bin/bash

frame_num="$1"

_dir=$(dirname "${0}")

cd "$_dir"
cd ..

{ ffmpeg -y -hide_banner -nostats -i video.vid \
-threads 1 -vf "select=gte(n\, ""$frame_num"") , showinfo" \
-an -sn -f image2pipe \
-vsync 0 \
-vframes 1 \
-vcodec rawvideo -pix_fmt yuv420p /dev/null \
< /dev/null 2>&3 ; } 3>&1 1>/dev/null | grep 'pts_time:' 2> /dev/null \
| head -1 2> /dev/null \
| sed -e 's#.* pts_time:##'|sed -e 's# .*##'


