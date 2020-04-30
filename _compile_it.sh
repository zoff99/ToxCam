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

mkdir -p $_SRC_
mkdir -p $_INST_

export LD_LIBRARY_PATH=$_INST_/lib/
export PKG_CONFIG_PATH=$_INST_/lib/pkgconfig

full="0"


if [ "$full""x" == "1x" ]; then


cd $_HOME_/build
rm -Rf x264
git clone https://code.videolan.org/videolan/x264.git
cd x264
git checkout 1771b556ee45207f8711744ccbd5d42a3949b14c # stable
export CFLAGS=" -g -O3 -I$_INST_/include/ -fPIC -Wall -Wextra "
export CXXFLAGS="-fPIC"
export LDFLAGS=" -O3 -L$_INST_/lib  -fPIC"
./configure --prefix=$_INST_ --disable-opencl --enable-static \
--disable-avs --disable-cli --enable-pic || exit 1
make -j12 || exit 1
make install

fi



if [ "$full""x" == "1x" ]; then


cd $_HOME_/build
rm -Rf libav
git clone https://github.com/FFmpeg/FFmpeg libav
cd libav
git checkout n4.2.1
export CFLAGS=" -g -O3 -I$_INST_/include/ -fPIC -Wall -Wextra "
export CXXFLAGS="-fPIC"
export LDFLAGS=" -O3 -L$_INST_/lib  -fPIC"

./configure --prefix=$_INST_ --disable-devices \
--enable-pthreads \
--disable-everything \
--disable-shared --enable-static \
--disable-doc --disable-avdevice \
--disable-network \
--enable-ffmpeg --enable-ffprobe \
--disable-network \
--disable-bzlib \
--disable-libxcb-shm \
--disable-libxcb-xfixes \
--enable-parser=h264 \
--enable-runtime-cpudetect \
--disable-nvenc \
--disable-nvdec \
--disable-vaapi \
--disable-vdpau \
--disable-ffnvcodec \
--disable-cuvid \
--disable-libxcb \
--disable-xlib \
--disable-lzma \
--disable-iconv \
--disable-alsa \
--disable-hwaccels \
--enable-libx264 \
--enable-encoder=libx264 \
--enable-gpl --enable-decoder=h264 || exit 1

make -j12 || exit 1
make install


fi





if [ "$full""x" == "1x" ]; then

cd $_HOME_/build
rm -Rf libsodium
git clone https://github.com/jedisct1/libsodium
cd libsodium
git checkout 1.0.18
autoreconf -fi
export CFLAGS=" -g -O3 -I$_INST_/include/ -Wall -Wextra "
export CXXFLAGS=" -g -O3 -I$_INST_/include/ -Wall -Wextra "
export LDFLAGS=" -O3 -L$_INST_/lib "
./configure --prefix=$_INST_ --disable-shared --disable-soname-versions || exit 1
make -j4 || exit 1
make install

fi

if [ "$full""x" == "1x" ]; then

cd $_HOME_/build
rm -Rf opus
git clone https://github.com/xiph/opus.git
cd opus
git checkout v1.3.1
./autogen.sh
export CFLAGS=" -g -O3 -I$_INST_/include/ -Wall -Wextra "
export CXXFLAGS=" -g -O3 -I$_INST_/include/ -Wall -Wextra "
export LDFLAGS=" -O3 -L$_INST_/lib "
./configure --prefix=$_INST_ --disable-shared || exit 1
make -j 4 || exit 1
make install

fi

if [ "$full""x" == "1x" ]; then

cd $_HOME_/build
rm -Rf libvpx
git clone https://github.com/webmproject/libvpx.git
cd libvpx
git checkout v1.8.2
export CFLAGS=" -g -O3 -I$_INST_/include/ -Wall -Wextra "
export CXXFLAGS=" -g -O3 -I$_INST_/include/ -Wall -Wextra "
export LDFLAGS=" -O3 -L$_INST_/lib "
./configure --prefix=$_INST_ --disable-examples \
  --disable-unit-tests --enable-shared \
  --size-limit=16384x16384 \
  --enable-postproc --enable-multi-res-encoding \
  --enable-temporal-denoising --enable-vp9-temporal-denoising \
  --enable-vp9-postproc || exit 1
make -j 4 || exit 1
make install
unset CFLAGS
unset LDFLAGS



fi



cd $_HOME_/build

rsync -av /home/zoff/toxc2/c-toxcore/ ./c-toxcore/
cd c-toxcore

./autogen.sh

export CFLAGS=" -D_GNU_SOURCE -g -O0 -fPIC -I$_INST_/include/ -Wall -Wextra -Wno-unused-function -Wno-unused-parameter -Wno-unused-variable -Wno-unused-but-set-variable "
export CXXFLAGS="-fPIC"
export CFLAGS=" $CFLAGS -Werror=div-by-zero "
export LDFLAGS=" -O0 -fPIC -L$_INST_/lib "
./configure \
  --prefix=$_INST_ \
  --disable-soname-versions --enable-testing --enable-logging --disable-shared || exit 1

make clean

unset CFLAGS
unset LDFLAGS

make -j 4 || exit 1


make install


cd $_HOME_/build

