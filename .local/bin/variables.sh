#!/usr/bin/env bash

# since swww supports this, declare settings for it in the form of variables
export SWWW_TRANSITION="wipe"
export SWWW_TRANSITION_DURATION="1.7"
export SWWW_TRANSITION_FPS="144"

# config path for various apps
# useful for $XDG_CONFIG_HOME/hypr/scripts/animations.sh
export ALACRITTY_CFG="$XDG_CONFIG_HOME/alacritty/alacritty.toml"
export ROFI_CFG="$XDG_CONFIG_HOME/rofi/config.rasi"
export DUNST_CFG="$XDG_CONFIG_HOME/dunst/dunstrc"
export HYPRLAND_CFG="$XDG_CONFIG_HOME/hypr/hyprland.conf"
export HYPRLAND_RULES="$XDG_CONFIG_HOME/hypr/include/rules.conf"

# Icons
# example in $XDG_CONFIG_HOME/hypr/scripts/
export ICON="$XDG_CONFIG_HOME/hypr/icons"

# Brightness control

# export DDC_BUS_ADRESS="$(ddcutil detect | awk 'NR==2 {print substr($0, length($0))}')"
