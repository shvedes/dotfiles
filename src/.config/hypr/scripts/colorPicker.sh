#!/usr/bin/env bash

source $HOME/.local/bin/variables.sh

if ! command -v hyprpicker > /dev/null; then
	notify-send -r 3 -i "${ICON}/alert.svg" "Color picker" "Package \`hyprpicker\` not found"
	exit 1
fi

# comments generated by AI

COLOR_PICKER="$(hyprpicker -a)"

# If 'COLOR_PICKER' is empty (no color selected), exits the script
[[ -z "$COLOR_PICKER" ]] && exit

# Prepares a file path in the '/tmp' directory for the color image, using the color value as the filename.
IMAGE="/tmp/${COLOR_PICKER}".png

if ! command -v convert > /dev/null; then
	# If 'convert' is unavailable, sends a desktop notification that the color has been copied, 
	# using an icon specified by '${ICON}/eyedropper.svg'.
	notify-send -r 3 -i "${ICON}/eyedropper.svg" "Color picker" "${COLOR_PICKER} copied to clipboard"

else
	# Creates a 64x64 pixel image with the chosen color and saves it to 'IMAGE'.
	# Sends a desktop notification with the created image as an icon, 
	# indicating that the color value has been copied to the clipboard.
	convert -size 64x64 xc:"$COLOR_PICKER" "$IMAGE"
	notify-send -r 3 -i "$IMAGE" "Color picker" "${COLOR_PICKER} copied to clipboard"
fi
