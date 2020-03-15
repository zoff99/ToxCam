#! /bin/bash

_HOME2_=$(dirname $0)
export _HOME2_
_HOME_=$(cd $_HOME2_;pwd)
export _HOME_


echo $_HOME_
cd $_HOME_
mkdir -p build

export _SRC_=$_HOME_/build/
export _INST_=$_HOME_/inst/

echo $_SRC_
echo $_INST_


cd $_HOME_/toxcam

echo $_INST_/lib/
echo $_INST_/include/

gcc \
-O3 -g -Wall \
-o toxcam \
toxcam.c \
rb.c \
-std=gnu99 \
-L$_INST_/lib -I$_INST_/include/ \
-std=gnu99 \
-L$_HOME_/inst/lib/ \
$_INST_/lib/libtoxcore.a \
$_INST_/lib/libtoxav.a \
-lrt -lm \
$_INST_/lib/libopus.a \
$_INST_/lib/libvpx.a \
$_INST_/lib/libx264.a \
$_INST_/lib/libavcodec.a \
$_INST_/lib/libswresample.a \
$_INST_/lib/libavfilter.a \
$_INST_/lib/libavutil.a \
$_INST_/lib/libsodium.a \
-lasound \
-ldl \
-lz \
-lpthread -lv4lconvert

