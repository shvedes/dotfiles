#!/usr/bin/env bash

grim /tmp/lock_background.png
convert -blur 0x1 /tmp/lock_background.png /tmp/lock_background_post_processed.png && rm /tmp/lock_background.png
swaylock --config $HOME/.config/swaylock/config -i /tmp/lock_background_post_processed.png
