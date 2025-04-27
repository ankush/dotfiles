#!/bin/bash


# Attaching diff kb requires this for some reason
xset r rate 280 60
setxkbmap -option caps:escape

num_monitors=$(xrandr | grep -sw 'connected' | wc -l)
if [[ "$num_monitors" == 1 ]] ; then
	xrandr --output eDP --primary --mode 1920x1200 --pos 0x0 --rotate normal --output HDMI-A-0 --off --output DisplayPort-0 --off
	exit
fi

i3-nagbar -p -m "Pick Display Configurtion" -t warning \
	-b "Inbuilt"  "xrandr --output eDP --primary --mode 1920x1200 --pos 0x0 --rotate normal --output HDMI-A-0 --off --output DisplayPort-0 --off" \
	-b "Secondary"  "xrandr --output eDP --off --output HDMI-A-0 --off --output DisplayPort-0 --mode 1920x1080 --pos 0x0 --rotate normal" \
	-b "Both"  "xrandr --output eDP --primary --mode 1920x1200 --pos 1920x0 --rotate normal --output HDMI-A-0 --off --output DisplayPort-0 --mode 1920x1080 --pos 0x60 --rotate normal"


