#! /bin/bash

_HOME2_=$(dirname $0)
export _HOME2_
_HOME_=$(cd $_HOME2_;pwd)
export _HOME_

echo $_HOME_
cd $_HOME_

for i in $(ls -1 bots/*/workspace/db/toxid.txt); do cat $i;echo ; done > bot_ids.txt


