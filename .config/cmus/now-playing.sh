#!/bin/bash

if pgrep -x "cmus" > /dev/null
then
    cmusstatus=$(cmus-remote -Q)
    artist="$(grep artist -m 1 <<< "$cmusstatus" | cut -c 12-)"
    song="$(grep title -m 1 <<< "$cmusstatus" | cut -c 11-)"

    if [ ${#artist} -ge 25 ]
    then
        artist=${artist:0:23}
        artist+=" …"
    fi
    if [ ${#song} -ge 25 ]
    then
        song=${song:0:23}
        song+=" …"
    fi

    echo -n " $artist — $song"
else
    echo -n "ﱙ "
fi
