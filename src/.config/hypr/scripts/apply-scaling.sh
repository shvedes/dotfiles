#!/usr/bin/env bash

# Your monitor may not specifically support the scaling value listed here. If so, change to the value you need

source $HOME/.local/bin/variables.sh

CURRENT_STATE="$(grep monitor "$HYPRLAND_CFG" | awk '{print $6}')"
HYPR_BINDS_FILE="$HOME/.config/hypr/include/binds.conf"

case "$1" in
	up)
		if [[ "$CURRENT_STATE" == "1.0" ]]; then
			sed -i '/monitor/s/1.0/1.33/' "$HYPRLAND_CFG"
			sed -i '/rofi-theme/s/config.rasi/config-scaled.rasi/' "$HYPR_BINDS_FILE"
			hyprctl reload
			notify-send -r 9 -i "${ICON}/scale-in.svg" "Hyprland" "UI scaled"
		else
			notify-send -r 9 -i "${ICON}/scale-in.svg" "Hyprland" "Nothing to do"
		fi
		;;
	down)
		if [[ "$CURRENT_STATE" == "1.33" ]]; then
			sed -i '/monitor/s/1.33/1.0/' "$HYPRLAND_CFG"
			sed -i '/rofi-theme/s/config-scaled.rasi/config.rasi/' "$HYPR_BINDS_FILE"
			hyprctl reload
			notify-send -r 9 -i "${ICON}/scale-out.svg" "Hyprland" "UI scaling restored"
		else
			notify-send -r 9 -i "${ICON}/scale-out.svg" "Hyprland" "Nothing to do"
		fi
		;;
	*)
		echo "Unknown option"
		exit 1
esac
