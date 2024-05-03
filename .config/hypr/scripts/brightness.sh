#!/usr/bin/env bash

source $HOME/.local/bin/variables.sh

# https://en.wikipedia.org/wiki/Display_Data_Channel
# change the bus address to yours using `ddcutil detect`
# The problem with ddcutil is that it is slow. To speed it up at least a little, you need to use the git version of the program that supports the `--skip-ddc-checks` flag
# https://github.com/rockowitz/ddcutil/issues/110#issuecomment-1775603114

if ! command -v ddcutil > /dev/null; then
	notify-send -r 8 -i "${ICON}/alert.svg" "Brightness Control" "Package \`ddcutil\` not found"
	exit 1
fi

case "$1" in
	up)
		ddcutil --bus 4 --skip-ddc-checks --sleep-multiplier .1 --maxtries 1,1,1 setvcp 10 + 5
		;;
	down)
		ddcutil --bus 4 --skip-ddc-checks --sleep-multiplier .1 --maxtries 1,1,1 setvcp 10 - 5
		;;
esac
