#! /bin/bash

_HOME2_=$(dirname $0)
export _HOME2_
_HOME_=$(cd $_HOME2_;pwd)
export _HOME_

echo $_HOME_
cd $_HOME_


counter=1
while [ $counter -le "$1" ]
do
    cd "$_HOME_"
    counter_string=$(printf "%03d" "$counter")
    echo "setting up botnum: ""$counter_string"
    mkdir -p ./bots/"$counter_string"
    cd ./bots/"$counter_string"/
    "$_HOME_"/_spin_up_docker.sh
    ((counter++))
done
