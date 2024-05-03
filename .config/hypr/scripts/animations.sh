#!/usr/bin/env bash

source "$HOME/.local/bin/variables.sh"

hypr_blur_str="$(grep -n 'blur {' -A 1 "$HYPRLAND_CFG" | grep 'enabled' | awk '{print $1}' | sed 's/-//')"
hypr_anim_str="$(grep -n 'animations {' -A 1 "$HYPRLAND_CFG" | grep 'enabled' | awk '{print $1}' | sed 's/-//')"
hypr_opacity_str="$(grep -n -E 'class:\(\.\*\.\*\)' "$HYPRLAND_RULES" | awk '{print substr($0, 1, 1)}')"

case "$(hyprctl getoption decoration:blur:enabled | awk 'NR==1 {print $2}')" in
    1)
		sed -i "${hypr_blur_str}s/true/false/" "$HYPRLAND_CFG"
		sed -i "${hypr_anim_str}s/true/false/" "$HYPRLAND_CFG"
		sed -i "${hypr_opacity_str}s/0.92/1/"  "$HYPRLAND_RULES"

		sed -i '/background/s/0.7/1/'			"$ROFI_CFG"
		sed -i '/background/s/28282866/282828/' "$DUNST_CFG"
		sed -i '/opacity/s/0.7/1/'				"$ALACRITTY_CFG"

		sed -i '/SWWW_TRANSITION/s/wipe/none/' $HOME/.local/bin/variables.sh

		hyprctl reload > /dev/null && killall dunst
        notify-send -r 4 -i "${ICON}/animations-off.svg" "Hyprland" "Animations disabled"
        ;;
    *)
		sed -i "${hypr_blur_str}s/false/true/" "$HYPRLAND_CFG"
		sed -i "${hypr_anim_str}s/false/true/" "$HYPRLAND_CFG"
		sed -i "${hypr_opacity_str}s/1/0.92/"  "$HYPRLAND_RULES"

		sed -i '/background/s/1/0.7/'			"$ROFI_CFG"
		sed -i '/background/s/282828/28282866/' "$DUNST_CFG"
		sed -i '/opacity/s/1/0.7/'				"$ALACRITTY_CFG"

		sed -i '/SWWW_TRANSITION/s/none/wipe/' $HOME/.local/bin/variables.sh

		hyprctl reload > /dev/null && killall dunst
        notify-send -r 4 -i "${ICON}/animations-on.svg" "Hyprland" "Animations enabled"
esac
