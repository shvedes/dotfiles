#!/usr/bin/env bash

source $HOME/.local/bin/variables.sh

if ! command -v cliphist > /dev/null; then
	notify-send -r 8 -i "${ICON}/alert.svg" "Clipboard manager" "Package \`cliphist\` not found"
	exit 1
fi

if ! command -v rofi > /dev/null; then
	notify-send -r 8 -i "${ICON}/alert.svg" "Clipboard manager" "Package \`rofi\` not found"
	exit 1
fi

case "$1" in
	show)
		cliphist list | rofi -dmenu -display-columns 2 -theme "$ROFI_CFG" | cliphist decode | wl-copy
		;;
	clear)
		cliphist wipe && notify-send -r 8 -i "${ICON}/clipboard.svg" "Clipboard manager" "Clipboard cleaned"
esac

