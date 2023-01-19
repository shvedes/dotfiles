#!/usr/bin/env bash

# --- Kill all existig bars and start new one --- #
while pgrep -u $UUID -x polybar > /dev/null; do sleep 1; done
polybar eDP &

# --- Launch polybar on external monitor (if connected) --- #
if [[ $(xrandr -q | grep -o 'HDMI-A-0 connected') ]]; then
    polybar HDMI &
fi
