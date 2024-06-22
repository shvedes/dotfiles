#!/usr/bin/env bash

source $HOME/.local/bin/variables.sh

# You might ask, why not use the ready-made script (https://wiki.hyprland.org/Configuring/Uncommon-tips--tricks/#toggle-animationsbluretc-hotkey)?
# Because of window rules. When the script above is used, all animations, blur etc are indeed removed, 
# however windows that had transparency for blur are now transparent completely, which may not be a problem, but I don't like it.
# So to make everything perfect, you also need to handle the window rules in the Hyprland config as well as the terminal, rofi and configs

# How to use?
# Lutris > Preferences > Global options > Game execution > Pre-launch script: gamemode.sh enable, Post-exit script: gamemode.sh disable

export ROFI_CFG_SCALED="$HOME/.config/rofi/config-scaled.rasi"

STATUS=$(hyprctl getoption animations:enabled | awk 'NR==1{print $2}')
ANIM_STR="$(awk '/animations/ {getline; print NR ":" $0}' "$HYPRLAND_CFG" | awk '{print $1}' | sed 's/://')"
BLUR_STR="$(awk '/blur/ {getline; print NR ":" $0}' "$HYPRLAND_CFG" | awk 'NR==1' | awk '{print $1}' | sed 's/://')"

enable_gamemode() {
	sed -i "${ANIM_STR}s/true/false/"		"$HYPRLAND_CFG"
	sed -i "${BLUR_STR}s/true/false/"		"$HYPRLAND_CFG"
	sed -i '2s/0.90/1/'						"$HYPRLAND_RULES"
	sed -i '/opacity/s/0.9/1/'				"$ALACRITTY_CFG"
	sed -i '/background/s/28282866/282828/' "$DUNST_CFG"
	sed -i '16s/0.7/1/'						"$ROFI_CFG"
	sed -i '16s/0.7/1/'						"$ROFI_CFG_SCALED"

	kill $(pgrep -a dunst | awk '{print $1}') 2> /dev/null
	hyprctl reload > /dev/null
}


disable_gamemode() {
	sed -i "${ANIM_STR}s/false/true/"		"$HYPRLAND_CFG"
	sed -i "${BLUR_STR}s/false/true/"		"$HYPRLAND_CFG"
	sed -i '2s/1/0.90/'						"$HYPRLAND_RULES"
	sed -i '/opacity/s/1/0.9/'				"$ALACRITTY_CFG"
	sed -i '/background/s/282828/28282866/' "$DUNST_CFG"
	sed -i '16s/1/0.7/'						"$ROFI_CFG"
	sed -i '16s/1/0.7/'						"$ROFI_CFG_SCALED"

	kill $(pgrep -a dunst | awk '{print $1}') 2> /dev/null
	hyprctl reload > /dev/null
}

if [[ "$HYPRLAND_ANIMATIONS" == "1" ]]; then
	if [[ "$1" == "enable" ]]; then
		enable_gamemode
		notify-send -r 5 -i "${ICON}/gamemode-on.svg" "Hyprland" "Gamemode enabled"
	elif [[ "$1" == "disable" ]]; then
		disable_gamemode
		notify-send -r 5 -i "${ICON}/gamemode-off.svg" "Hyprland" "Gamemode disabled"
	fi
else
	if [[ "$1" == "enable" ]]; then
		notify-send -r 5 -i "${ICON}/gamemode-on.svg" "Hyprland" "Gamemode enabled"
	elif [[ "$1" == "disable" ]]; then
		notify-send -r 5 -i "${ICON}/gamemode-off.svg" "Hyprland" "Gamemode disabled"
	fi
fi
