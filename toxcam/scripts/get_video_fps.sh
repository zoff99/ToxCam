#! /bin/bash

_dir=$(dirname "${0}")

cd "$_dir"
cd ..

fps_str=$(ffprobe -v error -select_streams v:0 -show_entries stream=avg_frame_rate -of default=noprint_wrappers=1:nokey=1 video.vid)
FPS_=$(printf 'scale=2\n'"$fps_str \n"|bc 2>/dev/null)

echo $FPS_
