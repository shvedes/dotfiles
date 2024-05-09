#!/usr/bin/env bash

source $HOME/.local/bin/variables.sh

DATE=$(date +"%A, %dth %B")

notify-send -r 2 -i "${ICON}/calendar.svg" "Date" "$DATE"
