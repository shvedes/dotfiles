#!/usr/bin/env zsh 


source $HOME/.oh-my-zsh/custom/plugins/auto-pair/autopair.zsh
# source $HOME/.oh-my-zsh/custom/plugins/catppuccin_mocha-zsh-syntax-highlighting.zsh export ZSH="$HOME/.oh-my-zsh"

# autostart xinit
if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then 
exec startx &> $HOME/.cache/wmlog
fi

ZSH_THEME="frontcube-custom"
ZSH_CACHE_DIR="$HOME/.cache/omz"
DISABLE_AUTO_TITLE=true
ENABLE_CORRECTION=false

# Plugin ---------------------------------------------------------------------- # 

autopair-init       

plugins=(
    
    # --- Highlight syntax --- #
    zsh-syntax-highlighting 

    # --- Autosuggestions --- # 
    zsh-autosuggestions

    # --- Colorize man pages --- #
    colored-man-pages

    # --- Ctrl + z to bg/fg task --- #
    fancy-ctrl-z

    # --- Copy current command in prompt to clipboard (ctrl + o) --- #
    copybuffer

    # --- Copy absolute patch of file --- #
    copypath

    # --- Colorize ls output --- #
    exa-zsh

    # --- Systemctl aliases --- #
    systemd

    # --- Double tab to add "sudo" to begin pof prompt --- #
    sudo

    # --- Allow searching from terminal --- #
    web-search
)

source $HOME/.oh-my-zsh/oh-my-zsh.sh

# Aliases ---------------------------------------------------------------------- # 

# --- Neofetch --- #
alias nf="neofetch --ascii ~/.config/neofetch/uwu_arch"

# --- Multitool --- # 
alias mtool="sh $HOME/.local/bin/scripts/multitool/mtool.sh"

# --- Free ram --- #
alias free="free --mega"

# --- Muc info --- #
alias muc="muc -p -c 10 --shell="zsh" -f $HOME/.zsh_history"

# --- Clear RAM --- #
alias ram="sudo sh -c 'echo 3 > /proc/sys/vm/drop_caches'"

# --- Rich Presence --- #
alias rpc="node ~/.local/bin/scripts/rpc/index.js &"

# --- Stop Rich Presence --- #
alias stoprpc="killall node"

# --- Color bars --- #
alias palette="$HOME/.local/bin/scripts/ascii/colorbar"

# --- Fuck command --- # 
alias .="fuck"

# --- Verbose default commands --- # 

alias cp="cp -v "
alias rm="rm -v "
alias du="du -hs"
alias mkdir="mkdir -pv "
alias rmdir="rmdir -v "
alias tr="tree --icons -a"

# Keymappings ---------------------------------------------------------------------- # 
