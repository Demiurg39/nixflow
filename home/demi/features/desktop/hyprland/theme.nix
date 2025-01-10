{ ... }: {

  wayland.windowManager.hyprland.settings = {

    general = {
      border_size = 2;
      gaps_in = 7;
      gaps_out = 10;
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
          "wind, 0.05, 0.9, 0.1, 1.05"
          "winIn, 0.1, 1.1, 0.1, 1.1"
          "winOut, 0.3, -0.3, 0, 1"
          "liner, 1, 1, 1, 1"
          "wobble, 0.1, 0.8, 0.9, 1.1"
      ];

      animation = [ 
      "windows, 1, 6, wind, slide"
      "windowsIn, 1, 6, winIn, slide"
      "windowsOut, 1, 5, winOut, slide"
      "windowsMove, 1, 3, wobble, slide"
      "border, 1, 1, liner"
      "borderangle, 1, 30, liner, loop"
      "fade, 1, 10, default"
      "workspaces, 1, 5, wind"
      ];
    };
    
  };

}
