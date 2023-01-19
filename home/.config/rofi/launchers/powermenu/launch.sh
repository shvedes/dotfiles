#!/usr/bin/env bash
dir="$HOME/.config/rofi/launchers/powermenu/"
theme='powermenu'

shutdown=''
reboot=''
lock=''
suspend=''
logout=''

rofi_cmd() {
	rofi -dmenu \
		 -theme ${dir}/${theme}.rasi
}

run_rofi() {
	echo -e "$lock\n$suspend\n$logout\n$reboot\n$shutdown" | rofi_cmd
}

chosen="$(run_rofi)"
case ${chosen} in
    $shutdown)
		systemctl poweroff
        ;;
    $reboot)
		systemctl reboot
        ;;
    $lock)
		betterlockscreen -l
        ;;
    $suspend)
		systemctl suspend
        ;;
    $logout)
		bspc quit
        ;;
esac
