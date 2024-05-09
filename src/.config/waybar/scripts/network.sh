#!/usr/bin/env bash

source $HOME/.local/bin/variables.sh

COMMAND="$(nmcli connection show | awk 'NR=1 {print $1}' | sed -n '2p')"

if [[ "$COMMAND" == "Wired" ]]; then
	notify-send -r 2 -i "${ICON}/ethernet.svg" "Connection" "Ethernet connected"
else
	notify-send -r 2 -i "${ICON}/wifi.svg" "Connection" "Connected to $COMMAND"
fi
