
<div align='center'> 

[![](https://readme-typing-svg.demolab.com?font=JetBrains+Mono&size=32&duration=3000&pause=1000&color=EBDBB2&center=true&vCenter=true&random=false&width=435&lines=Gruvin')](https://git.io/typing-svg)

![](https://img.shields.io/github/stars/shvedes/dotfiles?style=for-the-badge&label=Stars&color=b57614)
![](https://img.shields.io/github/last-commit/shvedes/dotfiles?style=for-the-badge&color=b57614)
![](https://img.shields.io/github/license/shvedes/dotfiles?style=for-the-badge&color=b57614)

![](https://img.shields.io/github/repo-size/shvedes/dotfiles?style=for-the-badge&logoColor=%23ffffff&label=Size&color=%23b57614)

</div>

![](https://preview.redd.it/hyprland-gruvin-v0-my6ax582ocxc1.png?width=1080&crop=smart&auto=webp&s=e45605d649a3c7af13811c87a5c3e096d1321895)

More screenshots [here](./Screenshots.md)

## Table of Contents
- [**Gruvin'**](#gruvin')
    - [**Colorscheme**](#colorscheme)
    - [**Tips and Tricks**](#tips-and-tricks)
    - [**List of Applications**](#list-of-applications)
- [**Getting Started**](#getting-started)
    - [**Important Note**](#important-note)
- [**To Do**](#to-do)

## Gruvin'
**Gruvin'** is the ultimate Hyprland settings with all the accompanying applications for comfortable and productive work on your PC.
Gruvin' does not use [**eww**](https://github.com/elkowar/eww) and similar utilities so that you do not waste time setting up this or that program. 

### Colorscheme

[**Gruvbox**](https://github.com/morhetz/gruvbox) as a color theme is used for reasons that are obvious to you (probably), namely:

- **Enhanced Readability**: Optimal contrast between text and background reduces eye strain.
- **Reduced Eye Fatigue**: Warm color tones are easier on the eyes, preventing fatigue and headaches. 
  Besides, this is the only color theme that doesn’t make my eyes get tired after just 10 minutes of looking at the screen, literally.
- **Pleasant Aesthetics**: Inviting color scheme creates a stimulating environment that boosts focus and productivity. Just try telling me I'm wrong.

### Tips and Tricks

Thinking about how to run Gparted natively under wayland? [Here's](https://github.com/shvedes/dotfiles/blob/main/src/.local/bin/applications/gparted.sh) the solution.

Instead of writing the `hyprctl activewindow` command along with the sleep command, and trying to catch the moment to get the parameters of the active window, you can simply press a couple of keys on the keyboard and get the desired output literally in a second in a convenient small window. Info [here](https://github.com/shvedes/dotfiles/blob/decfd0c8717e1497553c1a5edeebb91d6364144b/src/.config/hypr/include/binds.conf#L154C22-L154C29)

### List of Applications

As stated above, Gruvin' does not use unnecessary applications to make your desktop "look better", but still, I have to introduce you to the list of applications.

- **WM / Compositor** - hyprland
- **Lockscreen** - hyprlock
- **Idle Control** - hypridle
- **Bar** - waybar
- **Wallpapers** - swww
- **Notifications** - dunst
- **App Launcher** - rofi
- **Clipboard Manager** - cliphist
- **Display Manager** - ly

## Getting Started

> [!WARNING]
> Please understand that this is my personal configuration for my setup. If something doesn't work, feel free to open up an issue or message me, and I will try to help. However, before doing that, make sure you read the error output, use some common sense, and try to solve the problem yourself if it is something simple.

#### Important Note

For everything to work out of the box, please change the username in files where you need to specify an absolute path:

```bash
File: $HOME/.local/share/applications/gparted.desktop
File: $HOME/.local/share/applications/tools.desktop

```

Here is a complete list of packages that are needed for this configuration to work correctly.

```bash 
yay -S --noconfirm --needed hyprland hyprlock hypridle waybar swww dunst rofi-lbonn-wayland-only-git ttf-jetbrains-mono-nerd ttf-font-awesome noto-fonts noto-fonts-cjk imagemagick cliphist grim slurp jq zenity swayosd-git
```

> [!NOTE]
> waybar uses `noto-fonts`, which is why it is included in the list. Also, the spotify module can display Japanese characters if the title or artist of the track contains them. To do this you need `noto-fonts-cjk`
>
> ---
> `imagemagick` is used to convert a pixel color selected from the screen into a small image that will be displayed in a notification. If this package is not available, a pre-prepared svg image will be used. More [here](https://github.com/shvedes/dotfiles/blob/main/src/.config/hypr/scripts/colorPicker.sh).
>
> ---
> `jq` is used to define the borders of the active window when you want to take a screenshot.
>
> ---
> `zenity` is used to view active window options (via the key combination discussed above) and to launch applications that require root (such as gparted) while maintaining environment variables


## Troubleshooting

### Ly does not restart the dbus session after relogin

This is a [known](https://github.com/fairyglade/ly/issues/384) issue.
However, it can be solved by editing file that lunches wayland session. 
In `/usr/share/wayland-sessions/hyprland.desktop` change
```ini
Exec=Hyprland
```

to
```ini
Exec=env XDG_CURRENT_DESKTOP=Hyprland dbus-run-session Hyprland
```

> [!NOTE]
> You can also add `&> /dev/null` to the end of the line so that the log is not visible on your screen when Hyprland starts.
> This will not affect the crash report of the window manager.

## To Do

- [ ] Logout menu
- [ ] Polish everything to perfection
- [ ] Gamemode script, which will turn off animations, blurs, etc., when a particular game has been launched
- [ ] Make fractional scaling more usable. Also check note below
- [ ] Install script

> [!NOTE]
> For now fractional scaling does not affect the rofi menu, which will prevent you from seeing the app/clipboard lists
>
> ---
> List may be updated
