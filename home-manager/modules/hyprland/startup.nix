{
  wayland.windowManager.hyprland.settings = {

      "$srcPath" = "~/.local/bin";

      exec-once = [

      # █░░ ▄▀█ █░█ █▄░█ █▀▀ █░█
      # █▄▄ █▀█ █▄█ █░▀█ █▄▄ █▀█
     
      # See https://wiki.hyprland.org/Configuring/Keywords/

      # "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP" # for XDPH
     
      # exec-once = $scrPath/resetxdgportal.sh # reset XDPH for screenshare
      # exec-once = /usr/lib64/libexec/polkit-kde-authentication-agent-1 # kde authentication agent
      # exec-once = $scrPath/polkitkdeauth.sh # authentication dialogue for GUI apps
      # exec-once = waybar # launch the system bar
      # exec-once = hypridle # handles afk(low brightness, lock session, turn off screen)
      # exec-once = blueman-applet # systray app for Bluetooth
      # exec-once = udiskie --no-automount --smart-tray # front-end that allows to manage removable media
      # exec-once = nm-applet --indicator # systray app for Network/Wifi
      # exec-once = dunst # start notification demon
      # exec-once = wlsunset -t 5200 -S 8:00 -s 20:30 # NightLight from 8.30pm to 8.00am
      # exec-once = wl-paste --type text --watch cliphist store # clipboard store text data
      # exec-once = wl-paste --type image --watch cliphist store # clipboard store image data
      # exec-once = swww-daemon
      # exec-once = $scrPath/swwwallpaper.sh # start wallpaper daemon
      # exec-once = $scrPath/batterynotify.sh # battery notification
      # exec-once = $scrPath/idle.sh # lockscreen after 5 minutes, after 10 sleep

      # Bar, wallpaper
      # exec-once = swww-daemon --format xrgb
      # exec-once = /usr/lib/geoclue-2.0/demos/agent & gammastep
      # exec-once = ags &
      #
      # # Input method
      # exec-once = fcitx5
      #
      # # Core components (authentication, lock screen, notification daemon)
      # exec-once = gnome-keyring-daemon --start --components=secrets
      # exec-once = /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 || /usr/libexec/polkit-gnome-authentication-agent-1
      # exec-once = hypridle
      # exec-once = dbus-update-activation-environment --all
      # exec-once = sleep 1 && dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP # Some fix idk
      # exec-once = hyprpm reload
      #
      # # Audio
      # exec-once = easyeffects --gapplication-service
      #
      # # Clipboard: history
      # # exec-once = wl-paste --watch cliphist store &
      # exec-once = wl-paste --type text --watch cliphist store
      # exec-once = wl-paste --type image --watch cliphist store
      #
      # # Cursor
      # exec-once = hyprctl setcursor Bibata-Modern-Classic 24

      ];
  };
}
