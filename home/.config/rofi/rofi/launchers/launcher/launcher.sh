#!/usr/bin/env bash
# https://github.com/shvedes/dotfiles

dir="$HOME/.config/rofi/launchers/launcher"
theme='launcher'

## Run
rofi -show drun -theme ${dir}/${theme}.rasi
