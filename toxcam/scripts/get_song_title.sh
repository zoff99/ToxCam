#!/bin/bash

title=$(ffprobe 'http://stream01.superfly.fm:8080/live128' 2>&1|grep 'StreamTitle'|cut -d':' -f2|sed -e 's#^[ ]*##')
if [ "$title""x" == "x" ]; then
    title=$(ffprobe 'http://stream01.superfly.fm:8080/live128' 2>&1|grep 'icy-name'|cut -d':' -f2|sed -e 's#^[ ]*##')
fi

echo "$title"
