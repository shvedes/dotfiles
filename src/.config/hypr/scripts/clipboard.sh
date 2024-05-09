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
		if [[ $(cliphist list | wc -l) == "0" ]]; then
			notify-send -r 8 -i "${ICON}/bell.svg" "Clipboard Manager" "Clipboard is empty!"
		else
			cliphist list | rofi -dmenu -display-columns 2 -theme "$ROFI_CFG" -theme-str 'inputbar {enabled: false;}' | cliphist decode | wl-copy
		fi
		;;
	clear)
		cliphist wipe && notify-send -r 8 -i "${ICON}/clipboard.svg" "Clipboard manager" "Clipboard cleaned"
esac

