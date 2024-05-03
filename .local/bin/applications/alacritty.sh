#!/bin/sh

# If a terminal process already exists, create a new window in the same process
# This allows you to save RAM

pgrep -x alacritty > /dev/null 2>&1 && {
	nohup alacritty msg create-window &> /dev/null &
	exit
}

nohup alacritty &> /dev/null &
