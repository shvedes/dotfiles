#!/usr/bin/env bash

# So, we know that running applications from root on Wayand is a mess. 
# In order for the application to launch with the necessary variables, for example, a GTK theme,
# you need to copy its root user folder (or create symlnk, which I also think is not the most convenient solution), 
# and only then will it be applied (in this case, to GParted). For me, this is not the problem at all.
# What plays a big role for me is that this application is launched using XWayland.
# To solve this, you need to use the -E flag to sudo to import the current user's variables to run the application as root.
# I implemented this through a script, because, alas, if you run the program in this way through a .desktop file, 
# the polkit agent (in my case, gnome polkit) will not start, so I implemented it through zenity.

# Pros: GTK theme, native Wayland rendering
# Cons: I'm not sure, but it seems to me that it is not very safe. At least it works and that's all I need

source $HOME/.local/bin/variables.sh

if ! command -v zenity > /dev/null; then
	notify-send -r 9 -i "${ICON}/alert.svg" "Zenity" "Package \`zenity\` not found"
	exit 1
fi

if ! command -v gparted > /dev/null; then
	notify-send -r 9 -i "${ICON}/alert.svg" "GParted" "Package \`gparted\` not found"
	exit 1
fi

pass="$(zenity --password)"
echo "$pass" | sudo -S -E gparted &> /dev/null & 
