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


full="1"


if [ "$full""x" == "1x" ]; then

cd $_HOME_/build
rm -Rf libsodium
git clone https://github.com/jedisct1/libsodium
cd libsodium
git checkout 1.0.13
autoreconf -fi
./configure --prefix=$_INST_ --disable-shared --disable-soname-versions
make -j4
make install


cd $_HOME_/build
rm -Rf opus
git clone https://github.com/xiph/opus.git
cd opus
git checkout v1.2.1
./autogen.sh
./configure --prefix=$_INST_ --disable-shared
make -j 4
make install


cd $_HOME_/build
rm -Rf libvpx
git clone https://github.com/webmproject/libvpx.git
cd libvpx
git checkout v1.6.1
export CFLAGS=" -g -O3 -I$_INST_/include/ -Wall -Wextra "
export CXXFLAGS=" -g -O3 -I$_INST_/include/ -Wall -Wextra "
export LDFLAGS=" -O3 -L$_INST_/lib "
./configure --prefix=$_INST_ --disable-examples \
  --disable-unit-tests --enable-shared \
  --size-limit=16384x16384 \
  --enable-postproc --enable-multi-res-encoding \
  --enable-temporal-denoising --enable-vp9-temporal-denoising \
  --enable-vp9-postproc
make -j 4
make install
unset CFLAGS
unset LDFLAGS



fi




cd $_HOME_/build


if [ "$full""x" == "1x" ]; then
    rm -Rf c-toxcore
    git clone https://github.com/zoff99/c-toxcore
    cd c-toxcore
    git checkout "zoff99/_0.1.10_2017_video_fix_07a"
    ./autogen.sh
    export CFLAGS=" -D_GNU_SOURCE -g -O3 -I$_INST_/include/ -Wall -Wextra "
    export LDFLAGS=" -O3 -L$_INST_/lib "
    ./configure \
      --prefix=$_INST_ \
      --disable-soname-versions --disable-testing --disable-shared
    unset CFLAGS
    unset LDFLAGS
else
    rm -Rf c-toxcore
    git clone https://github.com/zoff99/c-toxcore
    cd c-toxcore
    git checkout "zoff99/_0.1.10_2017_video_fix_07a"
    ./autogen.sh

    export CFLAGS=" -D_GNU_SOURCE -g -O3 -I$_INST_/include/ -Wall -Wextra "
    export LDFLAGS=" -O3 -L$_INST_/lib "
    ./configure \
      --prefix=$_INST_ \
      --disable-soname-versions --enable-logging --disable-testing --disable-shared
    unset CFLAGS
    unset LDFLAGS

fi

make -j 4 || exit 1




make install


cd $_HOME_/build

