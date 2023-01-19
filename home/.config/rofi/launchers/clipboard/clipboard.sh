#!/usr/bin/env bash
# https://github.com/shvedes/dotfiles

theme="$HOME/.config/rofi/launchers/launcher/launcher.rasi"

rofi -modi "clipboard:greenclip print" -show clipboard -run-comand -theme $theme
