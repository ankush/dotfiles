#!/bin/bash

# adapted from https://github.com/CalinLeafshade/dots/blob/master/bin/bin/timeleft

DOD="2046-09-30"

function displaytime {
  local D=$(($1/60/60/24))
  (( $D > 0 )) && printf 'ﮊ %d ' $D
}

seconds=$(($(date --date="$DOD" +%s) - $(date +%s) ))

displaytime $seconds
