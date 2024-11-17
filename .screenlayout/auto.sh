#!/bin/bash

num_monitors=$(xrandr | grep -sw 'connected' | wc -l)

if [[ "$num_monitors" == 2 ]] ; then
	echo "Detected dual monitors"
	xrandr --output eDP --primary --mode 1920x1200 --pos 0x1080 --rotate normal --output HDMI-A-0 --off --output DisplayPort-0 --mode 1920x1080 --pos 0x0 --rotate normal --output DisplayPort-1 --off --output DisplayPort-2 --off --output DisplayPort-3 --off --output DisplayPort-4 --off --output DisplayPort-5 --off
else
	echo "Detected single monitor"
	xrandr --output eDP --primary --mode 1920x1200 --pos 0x0 --rotate normal --output HDMI-A-0 --off --output DisplayPort-0 --off --output DisplayPort-1 --off --output DisplayPort-2 --off --output DisplayPort-3 --off --output DisplayPort-4 --off --output DisplayPort-5 --off
fi

