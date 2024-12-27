#!/usr/bin/env sh

device=$(hyprctl -j devices | jq '.keyboards' | jq '.[] | select (.main == true)' | awk -F '"' '{if ($2=="name") print $4}')
hyprctl switchxkblayout ${device} next

layMain=$(hyprctl -j devices | jq '.keyboards' | jq '.[] | select (.main == true)' | awk -F '"' '{if ($2=="active_keymap") print $4}')
notify-send -a "t1" -r 91190 -t 800 -i "/home/demi/.config/dunst/icons/keyboard.svg" "${layMain}"
