#!/usr/bin/env bash

source $HOME/.local/bin/utils.sh
source $HOME/.local/bin/variables.sh

WALLPAPERS="$HOME/Wallpapers"

if ! command -v swww &> /dev/null; then
	notify-send -i "${ICON}/alert.svg" -t 10000 "Wallpapers" "Package \`swww\` not found"
	exit 1
fi

if ! pidof swww-daemon &> /dev/null; then
	# restore prev wallpaper
	start swww-daemon
	echo "Restored previous wallpaper"
else
	# update wallpaper
	swww img "$(find "${WALLPAPERS}"/ -type f | shuf -n1)"
	echo "Wallpaper changed"
fi
