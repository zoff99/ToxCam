#! /bin/bash

frame_num="$1"
channels="$2"
samplerate="$3"

_dir=$(dirname "${0}")

cd "$_dir"
cd ..


{ ffmpeg -y -hide_banner -nostats -i video.vid \
-threads 1 \
-af "atrim=end_sample=$frame_num , ashowinfo" \
-acodec pcm_s16le -f s16le -ac "$channels" -ar "$samplerate" \
/dev/null </dev/null \
< /dev/null 2>&3 ; } 3>&1 1>/dev/null | grep 'pts_time:' 2> /dev/null \
| head -1 2> /dev/null \
| sed -e 's#.* pts_time:##'|sed -e 's# .*##'


