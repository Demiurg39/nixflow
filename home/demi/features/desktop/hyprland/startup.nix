{...}: {
  wayland.windowManager.hyprland.settings.exec-once = [
    # █░░ ▄▀█ █░█ █▄░█ █▀▀ █░█
    # █▄▄ █▀█ █▄█ █░▀█ █▄▄ █▀█

    # See https://wiki.hyprland.org/Configuring/Keywords/

    # "udiskie --no-automount --smart-tray" # front-end that allows to manage removable media
    "wlsunset -t 5200 -S 8:00 -s 20:30" # NightLight from 8.30pm to 8.00am

    "wl-paste --type text --watch cliphist store" # clipboard store text data
    "wl-paste --type image --watch cliphist store" # clipboard store image data

    "swww-daemon --format xrgb" # wallpapers daemon
    "illogical-impulse-ags-launcher" # top bar
    "hyprctl setcursor Bibata-Modern-Ice 24" # cursor theme

    # # Core components (authentication, lock screen, notification daemon)
    "dbus-update-activation-environment --all"
    "hypridle"

    # # Audio
    # "easyeffects --gapplication-service"
  ];
}
