#!/usr/bin/env bash

# pause Spotify if media is playing
if [[ "$(playerctl -p spotify status)" == "Playing" ]]; then
	playerctl -p spotify play-pause
fi

hyprlock & 
sleep 1 && systemctl suspend
