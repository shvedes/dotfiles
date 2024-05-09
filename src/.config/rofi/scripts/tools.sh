#!/usr/bin/env bash

# more options soon

source $HOME/.local/bin/variables.sh

ANIM_TEXT="Toogle animations"
ANIM_SRC="$HOME/.config/hypr/scripts/animations.sh"

MENU="$(echo -e "$ANIM_TEXT" | rofi -dmenu -theme "$ROFI_CFG")"

case "$MENU" in
	"$ANIM_TEXT")
		bash "$ANIM_SRC"
		;;
	*)
		rofi -show drun -theme "$ROFI_CFG"
esac
