{...}: {
  wayland.windowManager.hyprland.settings = {
    # █▀▄▀█ █▀█ █▄░█ █ ▀█▀ █▀█ █▀█
    # █░▀░█ █▄█ █░▀█ █ ░█░ █▄█ █▀▄

    # See https://wiki.hyprland.org/Configuring/Monitors/

    monitor = [
      "eDP-1,1920x1080@144,0x0,1"
      ",preferred,auto,auto"
    ];

    # █ █▄░█ █▀█ █░█ ▀█▀
    # █ █░▀█ █▀▀ █▄█ ░█░

    # See https://wiki.hyprland.org/Configuring/Variables/

    input = {
      kb_layout = "us,ru";
      kb_variant = "colemak_dh,";
      kb_options = "grp:space_toggle";
      numlock_by_default = true;
      follow_mouse = 1;

      touchpad = {
        natural_scroll = true;
        disable_while_typing = false;
        clickfinger_behavior = true;
        tap-to-click = true;
      };
    };

    # See https://wiki.hyprland.org/Configuring/Variables/

    gestures = {
      workspace_swipe = true;
      workspace_swipe_fingers = 4;
    };

    # █░░ ▄▀█ █▄█ █▀█ █░█ ▀█▀ █▀
    # █▄▄ █▀█ ░█░ █▄█ █▄█ ░█░ ▄█

    # See https://wiki.hyprland.org/Configuring/Dwindle-Layout/

    dwindle = {
      pseudotile = true;
      preserve_split = true;
    };

    # See https://wiki.hyprland.org/Configuring/Master-Layout/

    master = {
      new_status = "master";
    };

    # █▀▄▀█ █ █▀ █▀▀
    # █░▀░█ █ ▄█ █▄▄

    # See https://wiki.hyprland.org/Configuring/Variables/

    misc = {
      vrr = 0;
      vfr = true;
      disable_hyprland_logo = true;
      disable_splash_rendering = true;
      force_default_wallpaper = 0;
      mouse_move_enables_dpms = true;
      animate_manual_resizes = true;
      animate_mouse_windowdragging = true;
      mouse_move_focuses_monitor = true;
    };

    xwayland = {
      force_zero_scaling = true;
    };
  };
}
