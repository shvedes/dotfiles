#!/usr/bin/env bash

source $HOME/.local/bin/utils.sh
source $HOME/.local/bin/variables.sh

POLKIT="/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1"

bash $HOME/.config/hypr/scripts/wallpaper.sh & # keep executing in background to speed up 200-500ms (at least on my hardware)
pgrp waybar		|| start waybar

# core functionality first
start wl-paste --type text --watch cliphist store
start wl-paste --type image --watch cliphist store
start dex -a # start applications listed in $HOME/.config/autostart/

pgrp thunar		|| start thunar --daemon # https://wiki.archlinux.org/title/Thunar#Starting_in_daemon_mode
pgrp polkit-	|| start "$POLKIT" # polkit agent
pgrp server		|| start swayosd-server #  https://github.com/ErikReider/SwayOSD

# since i don't have display manager, and correspondingly, `graphical-session.target`, we need to start 
# this service manually
systemctl --user start  opentabletdriver.service
