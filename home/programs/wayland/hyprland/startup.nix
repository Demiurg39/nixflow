{...}: {
  wayland.windowManager.hyprland.settings.exec-once = [
    # █░░ ▄▀█ █░█ █▄░█ █▀▀ █░█
    # █▄▄ █▀█ █▄█ █░▀█ █▄▄ █▀█

    # See https://wiki.hyprland.org/Configuring/Keywords/

    "wl-paste --type text --watch cliphist store" # clipboard store text data
    "wl-paste --type image --watch cliphist store" # clipboard store image data

    "swww-daemon --format xrgb" # wallpapers daemon
    "illogical-impulse-ags-launcher" # top bar
    "hyprctl setcursor Bibata-Modern-Ice 24" # cursor theme

    # # Core components (authentication, lock screen, notification daemon)
    "dbus-update-activation-environment --all"

    # # Audio
    # "easyeffects --gapplication-service"
  ];
}
