#!/usr/bin/env bash

if [ "$(xrandr -q | grep -o 'HDMI-A-0 connected')" = "HDMI-A-0 connected" ]; then
    xrandr --output eDP --off
    xrandr --output HDMI-A-0 --primary --mode 1920x1080 --rate 120 --rotate normal --right-of eDP
else
    xrandr --output eDP --mode 1920x1200
fi

xsetroot -cursor_name left_ptr &
pgrep easyeffects   2> /dev/null || easyeffects  --gapplication-service &
pregp lxpolkit      2> /dev/null || lxpolkit &
pgrep greenclip     2> /dev/null || greenclip daemon &
pgrep picom         2> /dev/null || picom &
pgrep dunst         2> /dev/null || dunst &
redshift -P -O 5500

xinput set-prop 'GXTP7863:00 27C6:01E0 Touchpad' 'libinput Accel Speed' +0.3
xinput set-prop 'GXTP7863:00 27C6:01E0 Touchpad' 'libinput Natural Scrolling Enabled' 1
xinput set-prop 'GXTP7863:00 27C6:01E0 Touchpad' 'libinput Tapping Enabled' 1
xinput set-prop 'GXTP7863:00 27C6:01E0 Touchpad' 'libinput Scrolling Pixel Distance' 15
xinput set-prop 'Logitech G203 LIGHTSYNC Gaming Mouse' 'libinput Accel Speed' -0.5

exit 0
