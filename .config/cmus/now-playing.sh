#!/bin/bash

if pgrep -x "cmus" > /dev/null
then
    cmusstatus=$(cmus-remote -Q)
    artist=$(echo -n $(rg artist -m 1 <<< "$cmusstatus" | cut -c 12-))
    song=$(echo -n $(rg title -m 1 <<< "$cmusstatus" | cut -c 11-))
    echo -n " $artist ~ $song"
else
    echo -n "ﱙ "
fi
