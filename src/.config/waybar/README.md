# Waybar

## About file structure

```
.
├── scripts
│  ├── monitoring
│  │  └── source-code
│  │     └── temp.c
│  ├── date.sh
│  ├── network.sh
│  └── spotify.py
├── config
└── style.css
```
--- 

### `scripts/*.{sh,py}`

`date.sh` is

`network.sh` is

`spotify.py` is

### `scripts/monitoring`

Here are the binary files responsible for monitoring the hardware part of your PC. You can create them using the templates, which is located in the subfolder. This is a files C template that you can use to monitor CPU or GPU temperatures. By default, the interval between requests to sysfs is 300ms. 

Module example:
```json
  "custom/cpu": {
    "exec": "$HOME/.config/waybar/scripts/monitoring/cpu-temp",
    "format": "<span foreground='#d79921'>  </span>{}",
    "tooltip": false
  },

  "custom/gpu": {
    "exec": "$HOME/.config/waybar/scripts/monitoring/gpu-temp",
    "format": "<span foreground='#d79921'>  </span>{}",
    "tooltip": false
  },
```

##### Why this instead of built-in Waybar module?

Minimal interval for *temperature* module is 1 sec. You can set 0 as interval (which is realtime polling rate), but it will significantly increase CPU usage.
Implementation via sysfs allows you to set the interval to less than one second, without placing a load on the CPU
