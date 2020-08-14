#!/bin/bash

if pgrep -x "cmus" > /dev/null
then
    cmusstatus=$(cmus-remote -Q)
    artist=$(echo -n $(grep artist -m 1 <<< "$cmusstatus" | cut -c 12-))
    song=$(echo -n $(grep title -m 1 <<< "$cmusstatus" | cut -c 11-))

    if [ ${#artist} -ge 30 ]
    then
        artist=${artist:0:26}
        artist+=" ..."
    fi
    echo -n " $artist ~ $song"
else
    echo -n "ﱙ "
fi
