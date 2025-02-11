{...}: {
  wayland.windowManager.hyprland.settings = {
    general = {
      border_size = 2;
      gaps_in = 7;
      gaps_out = 10;

      # Fallback colors
      "col.active_border" = "rgba(0DB7D4FF)";
      "col.inactive_border" = "rgba(31313600)";
    };

    decoration = {
      rounding = 10;
      active_opacity = 0.9;
      inactive_opacity = 0.8;
      dim_special = 0.3;

      blur = {
        enabled = true;
        size = 8;
        passes = 2;
      };
    };

    # ▄▀█ █▄░█ █ █▀▄▀█ ▄▀█ ▀█▀ █ █▀█ █▄░█
    # █▀█ █░▀█ █ █░▀░█ █▀█ ░█░ █ █▄█ █░▀█

    # See https://wiki.hyprland.org/Configuring/Animations/

    animations = {
      enabled = true;
      bezier = [
        "wobble, 0.1, 0.8, 0.9, 1.1"
        "linear, 0, 0, 1, 1"
        "liner, 1, 1, 1, 1"
        "md3_standard, 0.2, 0, 0, 1"
        "md3_decel, 0.05, 0.7, 0.1, 1"
        "md3_accel, 0.3, 0, 0.8, 0.15"
        "overshot, 0.05, 0.9, 0.1, 1.1"
        "crazyshot, 0.1, 1.5, 0.76, 0.92 "
        "hyprnostretch, 0.05, 0.9, 0.1, 1.0"
        "menu_decel, 0.1, 1, 0, 1"
        "menu_accel, 0.38, 0.04, 1, 0.07"
        "easeInOutCirc, 0.85, 0, 0.15, 1"
        "easeOutCirc, 0, 0.55, 0.45, 1"
        "easeOutExpo, 0.16, 1, 0.3, 1"
        "softAcDecel, 0.26, 0.26, 0.15, 1"
        "md2, 0.4, 0, 0.2, 1" # use with .2s duration
      ];

      animation = [
        "windows, 1, 3, md3_decel, popin 60%"
        "windowsIn, 1, 3, md3_decel, popin 60%"
        "windowsOut, 1, 3, md3_accel, popin 60%"
        "windowsMove, 1, 3, wobble, slide"
        "border, 1, 10, default"
        "borderangle, 1, 30, liner, loop"
        "fade, 1, 3, md3_decel"
        # "layers, 1, 2, md3_decel, slide"
        "layersIn, 1, 3, menu_decel, slide"
        "layersOut, 1, 1.6, menu_accel"
        "fadeLayersIn, 1, 2, menu_decel"
        "fadeLayersOut, 1, 4.5, menu_accel"
        "workspaces, 1, 7, menu_decel, slide"
        # "workspaces, 1, 2.5, softAcDecel, slide"
        # "workspaces, 1, 7, menu_decel, slidefade 15%"
        # "specialWorkspace, 1, 3, md3_decel, slidefadevert 15%"
        "specialWorkspace, 1, 3, md3_decel, slidevert"
      ];
    };

    source = [
      "~/.cache/ags/user/generated/hypr/hyprland/colors.conf"
    ];
  };
}
