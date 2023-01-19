#!/usr/bin/env bash

# Variables --------------------------------------------------------------------------------------------------------------- #
export PRIMARY_DISPLAY="$(xrandr | awk '/ primary/{print $1}')"

pgerp easyeffects   2> /dev/null || easyeffects  --gapplication-service &
pregp lxpolkit      2> /dev/null || lxpolkit &
pgerp sxhkd         2> /dev/null || sxhkd &
pgrep greenclip     2> /dev/null || greenclip daemon &
pgrep picom         2> /dev/null || picom --experimental-backends &
redshift -P -O 5500
pgrep dunst     2> /dev/null || dunst -conf $HOME/.config/dunst/dunstrc &

# Other settings --------------------------------------------------------------------------------------------------------------- #

# --- launch polybar --- #
$HOME/.config/polybar/launch.sh & 

# --- Set brightness --- #
brightnessctl -q s 20

# --- Set random wallpaper from wallpaper folder --- #
feh -z --bg-fill ~/.wallpapers

# --- Fix cursor loading animation --- #
xsetroot -cursor_name left_ptr &

# --- Start screen saver --- #
pgrep -x xidlehook 2> /dev/null || xidlehook --not-when-audio --not-when-fullscreen --timer 300 'betterlockscreen -l' '' &

# --- Touchpad / mouse actions --- # 
xinput set-prop 'GXTP7863:00 27C6:01E0 Touchpad' 'libinput Accel Speed' +0.3
xinput set-prop 'GXTP7863:00 27C6:01E0 Touchpad' 'libinput Natural Scrolling Enabled' 1
xinput set-prop 'GXTP7863:00 27C6:01E0 Touchpad' 'libinput Tapping Enabled' 1
xinput set-prop 'GXTP7863:00 27C6:01E0 Touchpad' 'libinput Scrolling Pixel Distance' 15
xinput set-prop 'Logitech G203 LIGHTSYNC Gaming Mouse' 'libinput Accel Speed' -0.4

# --- Render betterlockscreen image if cached image is not exist --- #
[ ! -d "$HOME/.cache/betterlockscreen" ] && betterlockscreen -q -u  ~/.wallpapers/ --fx none

