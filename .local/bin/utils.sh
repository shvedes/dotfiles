#!/usr/bin/env bash

# This script contains useful functions and checks that will be imported and used in other scripts 

source $HOME/.local/bin/variables.sh

# Check for new updates. Arch(-based) only
# You can adapt this for your distro
check_updates() {
	if command -v checkupdates &> /dev/null; then
		while true; do
		  ping example.com -c 1 &> /dev/null
		  sleep 0.5
		  if [ $? -eq 0 ]; then
			break
		  fi
		done

		AVAILABLE_UPDATES="$(checkupdates | wc -l)"
		notify-send -r 1 -t 10000 -i "${ICON}/package.svg" "Package manager" "$AVAILABLE_UPDATES updates available"
	else
		notify-send -r 1 -t 10000 -u critical -i "${ICON}/alert.svg" "Package manager" "Package \`pacman-contrib\` not found"
	fi
}

# Start any command with their own flags detached from current terminal
start() {
	nohup "$@" &> /dev/null &
}

# Grep needed process without any output in stdout. Useful for `if else` cases
pgrp() {
    pgrep -x "$1" &> /dev/null
}
