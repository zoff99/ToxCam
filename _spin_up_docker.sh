#! /bin/bash

_HOME2_=$(dirname pwd)
export _HOME2_
_HOME_=$(cd $_HOME2_;pwd)
export _HOME_

_SCRIPTHOME2_=$(dirname $0)
export _SCRIPTHOME2_
_SCRIPTHOME_=$(cd $_SCRIPTHOME2_;pwd)
export _SCRIPTHOME_

echo $_HOME_
cd $_HOME_

# docker info

mkdir -p $_HOME_/script/
mkdir -p $_HOME_/workspace/

cp -av "$_SCRIPTHOME_"/toxcam/toxcam $_HOME_/workspace/
chmod a+rx $_HOME_/workspace/toxcam

echo '#! /bin/bash

## ----------------------
numcpus_=$(nproc)
quiet_=1
## ----------------------

echo "hello"

export qqq=""

if [ "$quiet_""x" == "1x" ]; then
	export qqq=" -qq "
fi


redirect_cmd() {
    if [ "$quiet_""x" == "1x" ]; then
        "$@" > /dev/null 2>&1
    else
        "$@"
    fi
}

# -------------------

echo "installing system packages ..."
redirect_cmd apt-get update $qqq


echo "installing more system packages ..."

pkgs="
    tor
    net-tools
"

for i in $pkgs ; do
    redirect_cmd apt-get install $qqq -y --force-yes --no-install-recommends $i
done

# -------------------

cd /workspace/
mkdir -p /workspace/db/
chmod a+rwx /workspace/db/

tor &
sleep 1

./toxcam -T

' > $_HOME_/script/do_it___external.sh

chmod a+rx $_HOME_/script/do_it___external.sh


system_to_build_for="ubuntu:18.04"

cd $_HOME_/
docker run -t -d --rm \
  -v $_HOME_/script:/script \
  -v $_HOME_/workspace:/workspace \
  "$system_to_build_for" \
  /bin/bash /script/do_it___external.sh; echo $?

