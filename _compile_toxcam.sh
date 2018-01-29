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


if [ 1 == 1 ]; then

gcc -O3 -g -Wall \
-o toxcam_static \
toxcam.c \
rb.c \
-static -std=gnu99 \
-L$_INST_/lib -I$_INST_/include/ \
-lsodium \
-ltoxcore -ltoxav \
-lsodium -lpthread -static-libgcc -static-libstdc++ -lopus \
-lvpx -lm -lpthread -lv4lconvert -ljpeg -lm -lrt -lpthread

else

gcc \
-fsanitize=address \
-O3 -g -Wall \
-o toxcam \
toxcam.c \
rb.c \
-std=gnu99 \
-L$_INST_/lib -I$_INST_/include/ \
-lsodium \
-ltoxcore -ltoxav \
-lsodium -lpthread -static-libgcc -static-libstdc++ -lopus \
-lvpx -lm -lpthread -lv4lconvert -ljpeg -lm -lrt -lpthread

fi
