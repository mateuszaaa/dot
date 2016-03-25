#!/bin/bash
HDMI2=`xrandr | grep 'HDMI2 connected'`
eDP1=`xrandr | grep 'eDP1 connected'`
DP1=`xrandr | grep 'DP1 connected'`
VGA1=`xrandr | grep 'DP1 connected'`

if [[ -n $HDMI2 && -n $eDP1 && -n $DP1 ]]; then
    sh ~/.config/i3/3_screens.sh
    exit 0
fi

if [[ -n $VGA1 && -n $eDP1 ]]; then
    echo "2"
    sh ~/.config/i3/2_screens.sh
    exit 0
fi

sh ~/.config/i3/1_screen.sh
