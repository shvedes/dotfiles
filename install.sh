#!/usr/bin/env bash

is_yay_installed() {
	if command -v yay > /dev/null; then
		echo "### Yay found. Preparing for package manager transaction"
	else
		echo "### Yay is not installed! Install it first and run this script again"
		exit 1
	fi
}

ask_user() {
	read -rp "### ${*} (y/n): " answer

	case "$answer" in
		[yY]|[yY][eE][sS])	return 0 ;;
		[nN]|[nN][oO])		return 1 ;;
	esac
}

is_arch() {
	source /etc/os-release

	if [[ "$ID" == "arch" || "$ID_LIKE" == "arch" ]]; then
		return 0
	else
		echo "### Only Arch-based distros is supported"
		echo "### Refer to ./pkg.list file for package list"
		exit 1
	fi
}

backup_configs() {
    local source_dir; source_dir="./src/.config"
    local target_dir="$HOME/.config"

    local folders=()
    for dir in "$source_dir"/*; do
        [[ -d "$dir" ]] && folders+=("$(basename "$dir")")
    done

    for folder in "${folders[@]}"; do
        local original="$target_dir/$folder"
        local backup="$original.bak"

        if [[ -d "$original" ]]; then
            echo "### Found ${original}! Backup saved to $backup"
            mv "$original" "$backup"
        fi
    done

	echo "### All your old configurations have been successfully backed up!"
}

active_monitor() {
    for connector in /sys/class/drm/*/status; do
        status=$(<"$connector")
        if [[ "$status" == "connected" ]]; then
            dir="${connector%/status}"
            name=$(basename "$dir" | sed 's/^card[0-9]*-//')

            if [ -f "$dir/crtc_id" ]; then
                crtc_id=$(<"$dir/crtc_id" 2>/dev/null)
                if [[ "$crtc_id" != "" && "$crtc_id" != "0" ]]; then
                    echo "$name"
                    return 0
                fi
            fi

            if [ -f "$dir/enabled" ]; then
                enabled=$(<"$dir/enabled" 2>/dev/null)
                if [[ "$enabled" == "enabled" ]]; then
                    echo "$name"
                    return 0
                fi
            fi

            if [ -s "$dir/modes" ]; then
                echo "$name"
                return 0
            fi
        fi
    done
    return 1
}

echo "##################################################################################################################################################"
echo "### Welcome, and thank you for choosing my dotfiles!"
echo "### You can use these dotfiles on your existing system, but I highly recommend a fresh Arch install"
echo "### Pre-existing custom environment variables might interfere with component functionality"
echo "##################################################################################################################################################"
echo "### This setup heavily relies on systemd to manage both GUI and non-GUI components while strictly following the XDG Base Directory specification."
echo "### This script allows you to install all necessary components and configurations with a single command. It will:"
echo "###    - Detect and back up your existing configs (Hyprland, Waybar, etc.)"
echo "###    - Install required packages (Arch only)"
echo "###    - Deploy new configurations"
echo "###    - Enable necessary custom systemd services"
echo "###    - Set up wallpapers"
echo "###    - Adjust the environment to match your username"
echo "##################################################################################################################################################"

if ask_user "### Would you like to proceed?"; then
	if is_arch; then
		echo "### Arch Linux system deteced!"

		if command -v yay > /dev/null; then
			echo "### Yay detected! Installing needed packages. You may need to enter your sudo password to do so"
			yay -Suy --needed --noconfirm $(cat ./pkg.list)
			echo "### Done! Needed pckages installed!"
		else
			echo "### Error! AUR helper not found!"
			echo "### Please, install yay and try again"
			exit 1
		fi
	fi
else
	echo "### Bye!"
	exit 1
fi

echo "### Copying new configuration files"
[ ! -d "$HOME/Pictures" ] && mkdir "$HOME/Pictures"

cp -r ./src/.scripts        "$HOME"
cp -r ./src/.config/*		"$HOME/.config"
cp -r ./src/.local/share/*	"$HOME/.local/share"
cp -r ./src/Wallpapers      "$HOME/Pictures"

echo "### Done!"

systemd_services=("hyprpaper" "hypridle" "hyprsunset" "waybar" "swayosd" "cliphist" "logout-screen" "lowfi" "polkit-gnome" "phone-connection")
enabled_services=()
ignored_services=()
packages_to_delete=()

if ask_user "Before enabling all services, I must ask: do you typically use night light?"; then
	while true; do
		read -rp "### What temperature do you typically use? (digits only): " temperature
		if [[ "$temperature" =~ ^[0-9]+$ ]]; then
			hyprsunset_temperature="$temperature"
			break
		else
			echo "### Please enter a valid number"
		fi
	done
else
	packages_to_delete+=("hyprsunset")
	ignored_services+=("hyprsunset")
fi

echo "### My setup includes a script and corresponding service that will ping the local IP of your phone (or any other device),"
echo "###     and as long as these devices are reachable, the system will not automatically suspend."
echo "### If you want to enable this service now, you will need to know the local IP of your device in advance."
echo "### If it's an Android device, you will most likely need to disable random MAC address generation in the network settings,"
echo "###     and also enable static DHCP for the specific device in the router settings."
echo "### If you're not sure, you can skip this step and configure it manually later."

if ask_user "Continue the operation?"; then
    while true; do
        read -rp "### Please, enter a local IP address (e.g. 192.168.1.158): " ip_address
        if [[ "$ip_address" =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
			sed -i "s/YOUR_LOCAL_IP_ADDRESS_HERE/$ip_address/" "$HOME/.config/systemd/user/phone-connection.service"
			sed -i "s/YOUR_LOCAL_IP_ADDRESS_HERE/$ip_address/" "$HOME/.config/waybar/config.jsonc"
			echo "### Done"
            break
        else
            echo "### Please enter a valid IP address (e.g. 192.168.1.158)"
        fi
    done
else
	packages_to_delete+=("inotify-tools")
	ignored_services+=("phone-connection")
fi

echo "### This setup also includes a service that, upon session startup, plays LoFi music in the background,"
echo "###     which will be available from the Waybar module."
echo "### It is paused by default, so it won't bother you when the system starts."

if ask_user "Would you like to use this service?"; then
	echo "### Great choise!"
else
	packages_to_delete+=("lowfi")
	ignored_services+=("lowfi")
fi

for service in "${systemd_services[@]}"; do
    ignored=false
    for ignored_service in "${ignored_services[@]}"; do
        if [[ "$ignored_service" == "$service" ]]; then
            ignored=true
            break
        fi
    done
    if ! $ignored; then
        enabled_services+=("$service")
    fi
done

echo "### Enabling needed systemd services"
for service in "${enabled_services[@]}"; do
	systemctl --user enable "$service"
done

echo "### Finishing..."

targets=("$HOME/.config/qt?ct/qt?ct.conf" "$HOME/.config/spicetify/config-xpui.ini" "$HOME/.config/swayosd/config.toml" "$HOME/.local/share/applications/custom-yt-dlp.desktop")
for target in "${targets[@]}"; do
	sed -i "s/username/$USER/g" "$target"
done

current_monitor="$(active_monitor)"
sed -i "s/MONITOR/$current_monitor/" "$HOME/.config/hypr/hyprpaper.conf"

echo "### And the final touch. To start the Hyprland session correctly,"
echo "###     you need to select the corresponding UWSM session in the Display Manager."
echo "### I use ly as the DM. To enable its systemd service, you will need to enter your password for the corresponding command."

if systemctl enable ly; then
	echo "### Done! Reboot your machine and enjoy!"
else
	echo "### Did you enabled the service? :/"
fi


echo "### Some notes:"
echo "### In the screenshots and Waybar config, you might have noticed the temperature modules for both CPU and GPU."
echo "### The issue is that they are strictly tied to a specific hwmon path, so you'll need to manually specify the correct hwmon path that applies to your PC build / laptop."
echo "### Also, to apply a custom Gruvbox theme for Steam, launch AdwSteamGtk and enable the custom CSS in the settings. A Steam restart is required."
echo "### Also, don't forget to set the desired cursor and icon theme in nwg-look."
echo "### You can use papirus-folders (available in AUR) to recolor Papirus icons to match Gruvbox theme, but this is optional."
