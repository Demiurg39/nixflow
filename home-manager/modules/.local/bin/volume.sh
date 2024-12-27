#!/usr/bin/env bash

iDIR="$HOME/.config/dunst/icons"

# Get Volume
get_volume() {
    volume=$(wpctl get-volume @DEFAULT_SINK@ | grep 'Volume: ' | cut -f2 -d ":")
    echo "scale=2; $volume*100" | bc | cut -f1 -d "."
}

# Get icons
get_icon() {
    current=$(get_volume)
    if [[ ("$current" -ge "0") && ("$current" -le "5") ]]; then
        icon="$iDIR/vol-0.svg"
    elif [[ ("$current" -ge "5") && ("$current" -le "10") ]]; then
        icon="$iDIR/vol-5.svg"
    elif [[ ("$current" -ge "10") && ("$current" -le "15") ]]; then
        icon="$iDIR/vol-10.svg"
    elif [[ ("$current" -ge "15") && ("$current" -le "20") ]]; then
        icon="$iDIR/vol-15.svg"
    elif [[ ("$current" -ge "20") && ("$current" -le "25") ]]; then
        icon="$iDIR/vol-20.svg"
    elif [[ ("$current" -ge "25") && ("$current" -le "30") ]]; then
        icon="$iDIR/vol-25.svg"
    elif [[ ("$current" -ge "30") && ("$current" -le "35") ]]; then
        icon="$iDIR/vol-30.svg"
    elif [[ ("$current" -ge "35") && ("$current" -le "40") ]]; then
        icon="$iDIR/vol-35.svg"
    elif [[ ("$current" -ge "40") && ("$current" -le "45") ]]; then
        icon="$iDIR/vol-40.svg"
    elif [[ ("$current" -ge "45") && ("$current" -le "50") ]]; then
        icon="$iDIR/vol-45.svg"
    elif [[ ("$current" -ge "50") && ("$current" -le "55") ]]; then
        icon="$iDIR/vol-50.svg"
    elif [[ ("$current" -ge "55") && ("$current" -le "60") ]]; then
        icon="$iDIR/vol-55.svg"
    elif [[ ("$current" -ge "60") && ("$current" -le "65") ]]; then
        icon="$iDIR/vol-60.svg"
    elif [[ ("$current" -ge "65") && ("$current" -le "70") ]]; then
        icon="$iDIR/vol-65.svg"
    elif [[ ("$current" -ge "70") && ("$current" -le "75") ]]; then
        icon="$iDIR/vol-70.svg"
    elif [[ ("$current" -ge "75") && ("$current" -le "80") ]]; then
        icon="$iDIR/vol-75.svg"
    elif [[ ("$current" -ge "80") && ("$current" -le "85") ]]; then
        icon="$iDIR/vol-80.svg"
    elif [[ ("$current" -ge "85") && ("$current" -le "90") ]]; then
        icon="$iDIR/vol-85.svg"
    elif [[ ("$current" -ge "90") && ("$current" -le "95") ]]; then
        icon="$iDIR/vol-90.svg"
    elif [[ ("$current" -ge "95") && ("$current" -le "100") ]]; then
        icon="$iDIR/vol-100.svg"
    fi

    echo $icon
}

# Notify
notify_user() {
    notify-send -h string:x-canonical-private-synchronous:sys-notify -u low -i "$(get_icon)" "Volume : $(get_volume) %"
}

# Increase Volume
inc_volume() {
    if [[ "$(get_volume)" -lt "100" ]]; then
        wpctl set-volume @DEFAULT_SINK@ 5%+ && notify_user
    fi
}

# Decrease Volume
dec_volume() {
    wpctl set-volume @DEFAULT_SINK@ 5%- && notify_user
}

# Toggle Mute
toggle_mute() {
    if [ "$(pactl get-sink-mute 0 | cut -f2 -d ' ')" == "no" ]; then
        wpctl set-mute @DEFAULT_SINK@ 1 && notify-send -h string:x-canonical-private-synchronous:sys-notify -u low -i "$iDIR/muted-speaker.svg" "Volume Switched OFF"
    elif [ "$(pactl get-sink-mute 0 | cut -f2 -d ' ')" == "yes" ]; then
        wpctl set-mute @DEFAULT_SINK@ 0 && notify-send -h string:x-canonical-private-synchronous:sys-notify -u low -i "$iDIR/unmuted-speaker.svg" "Volume Switched ON"
    fi
}

# Toggle Mic
toggle_mic() {
    if [ "$(pactl get-source-mute 0 | cut -f2 -d ' ')" == "no" ]; then
        wpctl set-mute @DEFAULT_SOURCE@ 1 && notify-send -h string:x-canonical-private-synchronous:sys-notify -u low -i "$iDIR/muted-mic.svg" "Microphone Switched OFF"
    elif [ "$(pactl get-source-mute 0 | cut -f2 -d ' ')" == "yes" ]; then
        wpctl set-mute @DEFAULT_SOURCE@ 0 && notify-send -h string:x-canonical-private-synchronous:sys-notify -u low -i "$iDIR/unmuted-mic.svg" "Microphone Switched ON"
    fi
}

# Execute accordingly
if [[ "$1" == "--get" ]]; then
    get_volume
elif [[ "$1" == "--inc" ]]; then
    inc_volume
elif [[ "$1" == "--dec" ]]; then
    dec_volume
elif [[ "$1" == "--toggle" ]]; then
    toggle_mute
elif [[ "$1" == "--toggle-mic" ]]; then
    toggle_mic
elif [[ "$1" == "--icon" ]]; then
    get_icon
else
    get_volume
fi
