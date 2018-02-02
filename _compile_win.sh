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


    ### ----------- win compile -----------
    mkdir $_HOME_/winbuild
    mkdir $_HOME_/win_cache
    ### ------- compile and install libsodium -------
    cd $_HOME_/winbuild; git clone https://github.com/jedisct1/libsodium.git
    cd $_HOME_/winbuild; cd libsodium ; git checkout "$LIBSODIUM_BRANCH"
    cd $_HOME_/winbuild; cd libsodium ; ./autogen.sh
    cd $_HOME_/winbuild; cd libsodium ; \
      export TARGET_HOST="--host=x86_64-w64-mingw32" ; \
      export TARGET_TRGT="--target=x86_64-win64-gcc" ; \
      export CROSS="x86_64-w64-mingw32-" ; \
      ./configure "$TARGET_HOST" --prefix=$_HOME_/win_cache/usr
    cd $_HOME_/winbuild; cd libsodium ; make -j4
    cd $_HOME_/winbuild; cd libsodium ; make install
    ### ------- compile and install libsodium -------


    ### ------- compile and install opus -------
    cd $_HOME_/winbuild; git clone https://github.com/xiph/opus
    cd $_HOME_/winbuild; cd opus ; git checkout "$OPUS_VERSION"
    cd $_HOME_/winbuild; cd opus ; ./autogen.sh
    cd $_HOME_/winbuild; cd opus ; \
      export TARGET_HOST="--host=x86_64-w64-mingw32" ; \
      export TARGET_TRGT="--target=x86_64-win64-gcc" ; \
      export CROSS="x86_64-w64-mingw32-" ; \
      export CFLAGS=" -g -O3 " ; \
      export CXXFLAGS=" -g -O3 " ; \
      ./configure "$TARGET_HOST" --prefix=$_HOME_/win_cache/usr \
      --disable-extra-programs --disable-doc
    cd $_HOME_/winbuild; cd opus ; make -j4
    cd $_HOME_/winbuild; cd opus ; make install
    ### ------- compile and install opus -------

    ### ------- compile and install libvpx -------
    cd $_HOME_/winbuild; git clone https://github.com/webmproject/libvpx.git
    cd $_HOME_/winbuild; cd libvpx ; git checkout "$LIBVPX_VERSION"
    cd $_HOME_/winbuild; cd libvpx ; ./autogen.sh
    cd $_HOME_/winbuild; cd libvpx ; \
      export TARGET_HOST="--host=x86_64-w64-mingw32" ; \
      export TARGET_TRGT="--target=x86_64-win64-gcc" ; \
      export CROSS="x86_64-w64-mingw32-" ; \
      export CFLAGS=" -g -O3 " ; \
      export CXXFLAGS=" -g -O3 " ; \
      CROSS=x86_64-w64-mingw32- ./configure "$TARGET_TRGT" \
      --prefix=$_HOME_/win_cache/usr \
      --enable-static \
      --size-limit=16384x16384 \
      --disable-shared \
      --disable-unit-tests \
      --enable-postproc \
      --enable-multi-res-encoding \
      --enable-temporal-denoising \
      --enable-vp9-temporal-denoising \
      --enable-vp9-postproc
    cd $_HOME_/winbuild; cd libvpx ; make -j4
    cd $_HOME_/winbuild; cd libvpx ; make install
    ### ------- compile and install libvpx -------

    ### ------- compile and install c-toxcore -------
    cd $_HOME_/winbuild; git clone "$CTOXCORE_URL"
    cd $_HOME_/winbuild; cd c-toxcore ; git checkout "$CTOXCORE_VERSION_HASH"
    cd $_HOME_/winbuild; cd c-toxcore ; ./autogen.sh
    cd $_HOME_/winbuild; cd c-toxcore ; \
      export PKG_CONFIG_PATH="$_HOME_//win_cache/usr/lib/pkgconfig" ; \
      export TARGET_HOST="--host=x86_64-w64-mingw32" ; \
      export TARGET_TRGT="--target=x86_64-win64-gcc" ; \
      export CROSS="x86_64-w64-mingw32-" ; \
      export LIBSODIUM_CFLAGS=" -I$_HOME_/win_cache/usr/include/ " \
      export LIBSODIUM_LIBS=" -L$_HOME_/win_cache/usr/lib/ -lsodium " \
      export CFLAGS=" -g -O3 -I$_HOME_/win_cache/usr/include/ " ; \
      export CXXFLAGS=" -g -O3 -I$_HOME_/win_cache/usr/include/ " ; \
      CROSS=x86_64-w64-mingw32- ./configure "$TARGET_HOST" --prefix=$_HOME_/win_cache/usr \
     --with-libsodium-headers=$_HOME_/win_cache/usr/include/ --with-libsodium-libs=$_HOME_/win_cache/usr/lib/ \
     --disable-soname-versions --disable-shared
    cd $_HOME_/winbuild; cd c-toxcore ; make VERBOSE=1 V=1
    cd $_HOME_/winbuild; cd c-toxcore ; make install
    ### ------- compile and install c-toxcore -------


    cd $_HOME_/winbuild/ ; git clone https://github.com/zoff99/ToxCam
    cd $_HOME_/winbuild/ ; cd ToxCam ; \
      git checkout "_video_test_04_stream_video_file_"
    cd $_HOME_/winbuild/ToxCam/toxcam/ ; \
      x86_64-w64-mingw32-gcc -O3 -g \
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

