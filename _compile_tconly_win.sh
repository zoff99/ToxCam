#! /bin/bash

cd $(dirname $0)

export _HOME_=$(pwd)
echo $_HOME_

    CTOXCORE_VERSION_HASH="zoff99/_0.1.10_2017_video_fix_08"
    # c-toxcore repo used
    # CTOXCORE_URL="https://github.com/TokTok/c-toxcore"
    CTOXCORE_URL="https://github.com/zoff99/c-toxcore"
    LIBSODIUM_VERSION="tags/1.0.13"
    LIBSODIUM_BRANCH="1.0.13"
    OPUS_VERSION="1.1.2"
    LIBVPX_VERSION="v1.7.0"
    RASPBERRRY_TOOLS_HASH=d820ab9c21969013b4e56c7e9cba25518afcdd44

    #cd $_HOME_/winbuild/ ; git clone https://github.com/zoff99/ToxCam
    #cd $_HOME_/winbuild/ ; cd ToxCam ; \
    #  git checkout "_video_test_04_stream_video_file_"
    cd $_HOME_/winbuild/ToxCam/toxcam/ ; \
      x86_64-w64-mingw32-gcc -O3 -g \
      -DWIN32 \
      -L$_HOME_/win_cache/usr/lib \
      -I$_HOME_/win_cache/usr/include/ \
      -o toxcam.exe toxcam.c rb.c -std=gnu99 \
      -lm \
      -ltoxcore -ltoxav -ltoxdns -ltoxencryptsave \
      -lws2_32 -liphlpapi \
      $_HOME_/win_cache/usr/lib/libvpx.a \
      $_HOME_/win_cache/usr/lib/libopus.a \
      $_HOME_/win_cache/usr/lib/libsodium.a \
      -static -lpthread

    cd $_HOME_/winbuild/ToxCam/toxcam/ ; ls -al toxcam.exe
    ### ----------- win compile -----------

