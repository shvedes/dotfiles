<div align='center'>

[![](https://readme-typing-svg.demolab.com?font=JetBrains+Mono&size=32&duration=3000&pause=1000&color=EBDBB2&center=true&vCenter=true&random=false&width=500&lines=Environment)](https://git.io/typing-svg)

</div>

## Hardware

Since my PC build consists solely of AMD components, the variable settings and drivers will be configured for the `amdgpu` driver. If you have an NVIDIA graphics card or Intel CPU, you'll need to refer to guides online. In this case, I can't help, sorry.

## Hyprland

### Environment variables

All variables that **Hyprland** exports for its operation and the operation of the graphical session are specified in the `vars.conf` file located at `$HOME/.config/hypr/include`

In this section, the format used will be `VARIABLE = VALUE` for readability. Keep in mind that the actual configuration supports syntax in the format `env = VARIABLE,VALUE`

#### Wayland

`SDL_VIDEODRIVER = wayland` - enables native Wayland support for SDL applications. You can read about SDL [here](https://www.libsdl.org/). Also check [this](https://wiki.archlinux.org/title/Wayland#SDL2).

`WLR_RENDERER = vulkan` - indicates the Wayland renderer, which handles graphics rendering and interaction with graphical clients in the Wayland environment.

`WLR_DRM_NO_ATOMIC = 1` - allow screen tearing in fullscreen applications (e.g. games). Experimental

`QT_QPA_PLATFORM = wayland;xcb` - enables native Wayland support for QT apps.

`GDK_BACKEND = wayland` - enables native Wayland support for GTK apps.

`ELECTRON_OZONE_PLATFORM_HINT` - enables native Wayland support for Electron based apps. Only electron v28+

#### Theming

Recently, Hyprland has introduced support for its own cursor format ([link](https://wiki.hyprland.org/Hypr-Ecosystem/hyprcursor), [link](https://github.com/hyprwm/hyprcursor)), which works natively with Wayland. However, not all applications support it, and I've had some issues with it, so I'm still using the old X11 cursor.


`XCURSOR_THEME = MaterialLightCursors` - just cursor [theme](https://github.com/varlesh/material-cursors).

`QT_QPA_PLATFORMTHEME = qt5ct` - applies the qt5ct theme. You need to have `qt5ct` installed.

`GTK_THEME = gruvbox` - GTK theme. 

`QT_WAYLAND_DISABLE_WINDOWDECORATION = 1` - disables window decorations for QT apps.

`BAT_THEME = gruvbox-dark` - [bat](https://github.com/sharkdp/bat) theme.


#### Hardware

`LIBVA_DRIVER_NAME = radeonsi` - hardware-accelerated video decoding and encoding.

`VDPAU_DRIVER = radeonsi` - indicates to use the VDPAU driver, which provides hardware acceleration support for video playback.

#### Other variables

`WINEDLLOVERRIDES = winemenubuilder.exe=d` - [link](https://www.reddit.com/r/linux_gaming/comments/h8zcfk/comment/futvexv/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button)

`MOZ_DISABLE_RDD_SANDBOX = 1` and `MOZ_ENABLE_WAYLAND = 1` - enables hardware-accelerated video decoding and native Wayland support. In recent versions of firefox these variables are applied automatically.

`MAKEFLAGS = -j16` - use 16 threads for faster compilaction.

`ELECTRON_TRASH = gvfs-trash` - trash support for Electron apps (e.g. Obsidian)

### Scripts

The scripts use programs that may not be installed on your system. If so, the script will display a notification about that.

`animations.sh` - a script that turns animations on/off. It's pretty poorly written, but it gets the job done.

`clipboard.sh` - clipboard manager. Works via rofi.

`colorPicker.sh` - allows you to select pixel color from any part of the screen.

`init.sh` - script that runs when Hyprland starts.

`screenshot.sh` - useful screenshots.

`wallpaper.sh` - set on start / change wallpapers by keybinds

### Icons

So, what is this? These icons are used in various scripts and scenarios implemented through notifications. For example, available updates, current date, connected network, etc.

## `$HOME/.local/bin`

Here are the files that take part in the correct operation of my "DE" :)

`theme.txt` - gruvbox colors are listed here.

`notify-send.txt` - just check this file.

`utils.sh` - "This script contains useful functions and checks that will be imported and used in other scripts"

`variables.sh` - this lists the environment variables that are imported in other scripts. This allows you to save the number of lines in other scripts.

`applications/alacritty.sh` and `applications/gparted.sh` - detailed comments in the files themselves.

## Waybar

See [Waybar README](./.config/waybar/README.md)

## Rofi

`tools.sh` - this script allows you to run other necessary scripts using rofi. For now there is only `animations.sh`, but in the future there will be other, more useful scripts.

## Applications to which the gruvbox is fully ported

- All qt5 and qt6 apps
- All GTK apps
- OBS. Actually, OBS is a QT6 application, so the qt6ct theme works out of the box, but I have a custom gruvbox theme for it that looks much better
- Zathura
- Rofi
- Dunst
- Bat
- Btop
- Alacritty
- Spicetify

## About Electron

Check `$HOME/.config/electron-flags.conf`

### Spotify

The same strategy as described above works here, only with the `spotify-flags.conf` file.

