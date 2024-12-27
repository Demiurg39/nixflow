#!/usr/bin/env bash

iDIR="$HOME/.config/dunst/icons"

# Get brightness
get_backlight() {
    LIGHT=$(printf "%.0f\n" $(brightnessctl g))
    echo "${LIGHT}"
}

# Get icons
get_icon() {
    current="$(get_backlight)"
    if [[ ("$current" -ge "0") && ("$current" -le "12") ]]; then
        icon="$iDIR/vol-0.svg"
    elif [[ ("$current" -ge "12") && ("$current" -le "24") ]]; then
        icon="$iDIR/vol-5.svg"
    elif [[ ("$current" -ge "24") && ("$current" -le "36") ]]; then
        icon="$iDIR/vol-10.svg"
    elif [[ ("$current" -ge "36") && ("$current" -le "48") ]]; then
        icon="$iDIR/vol-15.svg"
    elif [[ ("$current" -ge "48") && ("$current" -le "60") ]]; then
        icon="$iDIR/vol-20.svg"
    elif [[ ("$current" -ge "60") && ("$current" -le "72") ]]; then
        icon="$iDIR/vol-25.svg"
    elif [[ ("$current" -ge "72") && ("$current" -le "84") ]]; then
        icon="$iDIR/vol-30.svg"
    elif [[ ("$current" -ge "84") && ("$current" -le "96") ]]; then
        icon="$iDIR/vol-35.svg"
    elif [[ ("$current" -ge "96") && ("$current" -le "108") ]]; then
        icon="$iDIR/vol-40.svg"
    elif [[ ("$current" -ge "108") && ("$current" -le "120") ]]; then
        icon="$iDIR/vol-45.svg"
    elif [[ ("$current" -ge "120") && ("$current" -le "132") ]]; then
        icon="$iDIR/vol-50.svg"
    elif [[ ("$current" -ge "132") && ("$current" -le "144") ]]; then
        icon="$iDIR/vol-55.svg"
    elif [[ ("$current" -ge "144") && ("$current" -le "156") ]]; then
        icon="$iDIR/vol-60.svg"
    elif [[ ("$current" -ge "156") && ("$current" -le "168") ]]; then
        icon="$iDIR/vol-65.svg"
    elif [[ ("$current" -ge "168") && ("$current" -le "180") ]]; then
        icon="$iDIR/vol-70.svg"
    elif [[ ("$current" -ge "180") && ("$current" -le "192") ]]; then
        icon="$iDIR/vol-75.svg"
    elif [[ ("$current" -ge "192") && ("$current" -le "204") ]]; then
        icon="$iDIR/vol-80.svg"
    elif [[ ("$current" -ge "204") && ("$current" -le "216") ]]; then
        icon="$iDIR/vol-85.svg"
    elif [[ ("$current" -ge "216") && ("$current" -le "228") ]]; then
        icon="$iDIR/vol-90.svg"
    elif [[ ("$current" -ge "228") && ("$current" -le "240") ]]; then
        icon="$iDIR/vol-95.svg"
    elif [[ ("$current" -ge "240") && ("$current" -le "255") ]]; then
        icon="$iDIR/vol-100.svg"
    fi
}

# Notify
notify_user() {
    percent=$(echo "scale=2; $(get_backlight)/255*100" | bc | cut -f1 -d ".")
    notify-send -h string:x-canonical-private-synchronous:sys-notify -u low -i "$icon" "Brightness : $percent%"
}

# Increase brightness
inc_backlight() {
    brightnessctl s 12+ && get_icon && notify_user
}

# Decrease brightness
dec_backlight() {
    brightnessctl s 12- && get_icon && notify_user
}

# Execute accordingly
if [[ "$1" == "--get" ]]; then
    get_backlight
elif [[ "$1" == "--inc" ]]; then
    inc_backlight
elif [[ "$1" == "--dec" ]]; then
    dec_backlight
else
    get_backlight
fi
