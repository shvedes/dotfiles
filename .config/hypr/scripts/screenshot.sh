#!/usr/bin/env bash

# i don't need bloated hyprshot
# this simpler, better, and mine

source $HOME/.local/bin/variables.sh

if ! command -v slurp > /dev/null; then
	notify-send -r 8 -i "${ICON}/alert.svg" "Screenshot tool" "Package \`slurp\` not found"
	exit 1
fi

OUT="/tmp/screenshot.png"

notify() {
	notify-send -r 6 -i "${ICON}/screenshot.svg" "Screenshot tool" "Screenshot copied to clipboard"
}

case "$1" in 
	area) 
		slurp -b 00000080 -c a8998480 | grim -g - "$OUT" && [[ ! -f "$OUT" ]] && exit
		wl-copy < "$OUT" && notify && rm "$OUT"
		;;
	window)
		ACTIVE_WINDOW="$(hyprctl activewindow -j |  jq -r '"\(.at[0]),\(.at[1]) \(.size[0])x\(.size[1])"')"
		grim -g "$ACTIVE_WINDOW" "$OUT"
		wl-copy < "$OUT" && notify && rm "$OUT"
		;;
	screen)
		grim "$OUT"
		wl-copy < "$OUT" && notify && rm "$OUT"
esac
