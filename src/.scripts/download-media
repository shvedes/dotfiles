#!/usr/bin/env bash

# shellcheck disable=all

# Define the log file path where all actions will be recorded
log_file="$XDG_CACHE_HOME/download-media.log"

source "$XDG_CONFIG_HOME/user-dirs.dirs"

# Function: Display a Rofi menu for user input
# Parameters:
#   $1: Placeholder text for the input field
rofi_cmd() {
    rofi -dmenu \
         -display-columns 1 \
         -theme "$XDG_CONFIG_HOME/rofi/config.rasi" \
         -theme-str 'configuration {show-icons: false;} entry {placeholder: "'"$1"'";}'
}

# Function: Show an error notification and exit the script
# Parameters:
#   $1: Error message to display
error_notify() {
    notify-send "YouTube Download" "$1" -i "$XDG_CONFIG_HOME/hypr/icons/youtube.svg"
    exit 1
}

# Function: Log messages to the log file
# Parameters:
#   $*: Message to log
log() {
    echo "[$(date)] $*" >> "$log_file"
}

# Check if yt-dlp is installed
# If not, notify the user and exit the script.
if ! command -v yt-dlp &>/dev/null; then
    notify-send "YouTube Download" "yt-dlp is not installed!" -i "$XDG_CONFIG_HOME/hypr/icons/youtube.svg"
    exit 1
fi
log "yt-dlp is installed"

# Prompt the user to enter a URL using the Rofi menu
url="$(rofi_cmd "Enter URL here")"

# Check if the user provided a URL
# If no URL is provided, show an error notification and exit.
[ -z "$url" ] && error_notify "No URL provided!"
log "Received URL"

# Validate the URL format
# Supported formats include YouTube, Twitch clips, and Reddit packaged media.
echo "[$(date)] Validating URL" >> "$log_file"
[[ ! "$url" =~ ^https?://(www\.)?(youtube\.com/.*|youtu\.be/.*|twitch\.tv/[^/]+/clip/.*|packaged-media\.redd\.it/.*)$ ]] && {
    log "Invalid URL. Exiting"
    error_notify "Invalid URL!"
}
log "URL is valid"

# Ask the user what type of content they want to download (Video, Audio, or Cancel)
type="$(echo -e "Video\nAudio\nCancel" | rofi_cmd "Download as")"

# Check if the user canceled the operation or provided invalid input
[ -z "$type" ] && error_notify "Operation canceled"
[ "$type" == "Cancel" ] && error_notify "Operation canceled"
log "File type: $type"

# Set the default download folder
output_dir="$XDG_DOWNLOAD_DIR/youtube"

# If the user selected "Audio", ask additional questions about saving location and quality
if [[ "$type" == "Audio" ]]; then
    # Ask the user if they want to save the audio file in the Music directory
    save_to_music=$(echo -e "Yes\nNo\nCancel" | rofi_cmd "Save to $HOME/music")
    [ -z "$save_to_music" ] && error_notify "Operation canceled"
    [ "$save_to_music" == "Cancel" ] && error_notify "Operation canceled"
    [ "$save_to_music" == "Yes" ] && {
        output_dir="$XDG_MUSIC_DIR"
        log "Save folder was changed to $output_dir"
    }

    # Ask the user to choose the audio quality (Best, Average, Worst, or Cancel)
    quality="$(echo -e "Best\nAverage\nWorst\nCancel" | rofi_cmd "Choose audio quality")"
    [ -z "$quality" ] && error_notify "Operation canceled"
    [ "$quality" == "Cancel" ] && error_notify "Operation canceled"

    # Map the selected quality to a numeric value used by yt-dlp
    case "$quality" in
        Best)    quality=0  ;;
        Average) quality=5  ;;
        Worst)   quality=10 ;;
    esac
    log "Quality: $quality"
fi

# Ask the user if they want to use a custom filename or keep the default
custom_name="$(echo -e "Keep default\nCancel" | rofi_cmd "Enter custom filename")"
[ -z "$custom_name" ] && error_notify "Operation canceled"
[ "$custom_name" == "Cancel" ] && error_notify "Operation canceled"

# Set the output file path based on the user's choice
if [ "$custom_name" == "Keep default" ]; then
    output="$output_dir/%(title)s.%(ext)s"
    log "Keeping default filename"
else
    output="$output_dir/$custom_name.%(ext)s"
    log "Using custom filename: $custom_name"
fi

# Ensure the output directory exists; create it if it doesn't
[ ! -d "$output_dir" ] && mkdir -p "$output_dir"

# Perform the download based on the selected type (Audio or Video)
case "$type" in
    Audio)
        log "Downloading audio to $output_dir"
        notify-send "YouTube Download" "Downloading audio..." -i "$XDG_CONFIG_HOME/hypr/icons/youtube.svg"
        if yt-dlp "$url" --extract-audio --audio-format mp3 --audio-quality "$quality" --output "$output"; then
            log "Download complete"
            notify-send "YouTube Download" "Download complete!" -i "$XDG_CONFIG_HOME/hypr/icons/youtube.svg"
        fi
        ;;
    Video)
        log "Downloading video to $output_dir"
        notify-send "YouTube Download" "Downloading video..." -i "$XDG_CONFIG_HOME/hypr/icons/youtube.svg"
        if yt-dlp "$url" --format mp4 --output "$output"; then
            log "Download complete"
            notify-send "YouTube Download" "Download complete!" -i "$XDG_CONFIG_HOME/hypr/icons/youtube.svg"
        fi
        ;;
esac
