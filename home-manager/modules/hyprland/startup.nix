{
  wayland.windowManager.hyprland.settings.exec-once = [

    # █░░ ▄▀█ █░█ █▄░█ █▀▀ █░█
    # █▄▄ █▀█ █▄█ █░▀█ █▄▄ █▀█
   
    # See https://wiki.hyprland.org/Configuring/Keywords/

    # "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP" # for XDPH
   
    # waybar # launch the system bar
    # hypridle # handles afk(low brightness, lock session, turn off screen)
    # blueman-applet # systray app for Bluetooth
    # udiskie --no-automount --smart-tray # front-end that allows to manage removable media
    # nm-applet --indicator # systray app for Network/Wifi
    # dunst # start notification demon
    # wlsunset -t 5200 -S 8:00 -s 20:30 # NightLight from 8.30pm to 8.00am

    "wl-paste --type text --watch cliphist store" # clipboard store text data
    "wl-paste --type image --watch cliphist store" # clipboard store image data
    "swww-daemon --format xrgb" # wallpapers daemon
    # "hypridle"; # idling

    # Bar, wallpaper
    # /usr/lib/geoclue-2.0/demos/agent & gammastep
    # ags &
    
    # # Core components (authentication, lock screen, notification daemon)
    # gnome-keyring-daemon --start --components=secrets
    # /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 || /usr/libexec/polkit-gnome-authentication-agent-1
    # dbus-update-activation-environment --all
    # hyprpm reload

    # # Audio
    # easyeffects --gapplication-service

    ];
}
