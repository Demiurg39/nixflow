{
  config,
  inputs,
  lib,
  ...
}:
with lib; let
  cfg = config.modules.desktop.hyprland;
  axshellCfg = config.modules.desktop.hyprland.ax-shell;
  axshellSettings = config.home.programs.ax-shell;

  animation_type =
    if
      builtins.elem axshellSettings.bar.position [
        "Left"
        "Right"
      ]
    then "slidefadevert"
    else "slidefade";
in {
  options.modules.desktop.hyprland = {
    enable = mkEnableOption "TODO: ";
    extraConfig = mkOpt lines "";
    monitors = mkOpt (listOf (submodule {
      options = {
        output = mkOpt str "";
        resolution = mkOpt str "preferred";
        position = mkOpt str "auto";
        scale = mkOpt int 1;
        disable = mkOpt bool false;
        primary = mkOpt bool false;
      };
    })) [{}];
  };

  config = mkIf (cfg.enable) {
    modules.desktop.type = "wayland";

    programs.hyprland = {
      enable = true;
      package = inputs.hyprland.packages.${config.hostPlatform}.hyprland;
      portalPackage = inputs.hyprland.packages.${config.hostPlatform}.xdg-desktop-portal-hyprland;
      xwayland.enable = true;
    };

    hardware.graphics = {
      package = pkgs.unstable.mesa;
      package32 = pkgs.unstable.pkgsi686Linux.mesa;
    };

    environment.sessionVariables = {
      ELECTRON_OZONE_PLATFORM_HINT = "auto";
      NIXOS_OZONE_WL = "1";
      MOZ_ENABLE_WAYLAND = "1";
    };

    security.pam.services.hyprlock = {};

    ## Bootloader.
    # services.greetd = {
    #   enable = true;
    #   settings.default_session = {
    #     command = toString (pkgs.writeShellScript "hyprland-wrapper" ''
    #       trap 'systemctl --user stop hyprland-session.target; sleep 1' EXIT
    #       exec Hyprland >/dev/null
    #     '');
    #     user = config.user.name;
    #   };
    # };
    # environment.etc."greetd/environments".text = "Hyprland";

    home.extraConfig.wayland.windowManager.hyprland = {
      enable = true;

      package = null;
      portalPackage = null;

      systemd = {
        enable = true;
        variables = ["--all"];
      };

      extraConfig = ''
        source = ${axshellSettings.hyprlandColorsConfPath}

        general {
          col.active_border = rgb($primary)
          col.inactive_border = rgb($surface)
          gaps_in = 7;
          gaps_out = 10;
          border_size = 2;
          layout = dwindle
        }
      '';

      settings = {
        # █▀▄▀█ █▀█ █▄░█ █ ▀█▀ █▀█ █▀█
        # █░▀░█ █▄█ █░▀█ █ ░█░ █▄█ █▀▄

        # See https://wiki.hyprland.org/Configuring/Monitors/

        monitor = [
          ",preferred,auto,auto"
        ]; # NOTE: add here monitor from module config

        # █ █▄░█ █▀█ █░█ ▀█▀
        # █ █░▀█ █▀▀ █▄█ ░█░

        # See https://wiki.hyprland.org/Configuring/Variables/

        input = {
          kb_layout = "us,ru";
          kb_variant = "colemak_dh,";
          kb_options = "grp:win_space_toggle";
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

        decoration = {
          rounding = 10;
          active_opacity = 0.9;
          inactive_opacity = 0.8;
          dim_special = 0.3;

          blur = {
            enabled = true;
            size = 8;
            passes = 3;
            new_optimizations = true;
            contrast = 1;
            brightness = 1;
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
            "layers, 1, 2, md3_decel, slide"
            "layersIn, 1, 3, menu_decel, slide"
            "layersOut, 1, 1.6, menu_accel"
            "fadeLayersIn, 1, 2, menu_decel"
            "fadeLayersOut, 1, 4.5, menu_accel"
            "workspaces, 1, 7, menu_decel, slide"
            "workspaces, 1, 2.5, softAcDecel, ${animation_type} 20%"
            "specialWorkspace, 1, 3, md3_decel, ${animation_type} 20%"
          ];
        };

        # Main modifier
        "$mainMod" = "Super"; # super / meta / windows key

        # Assign apps
        "$term" = "kitty";
        "$editor" = "neovide";
        "$file" = "nemo";
        "$browser" = "qutebrowser";
        "$sysmon" = "missioncenter";

        bind =
          [
            "$mainMod, Q, exec, hyprctl dispatch killactive" # close focused window
            "Alt,F4, exec, hyprctl dispatch killactive" # close focused window
            "$mainMod+Shift+Alt, Delete, exit," # kill hyprland session
            "$mainMod+Shift, Space, togglefloating," # toggle the window between focus and float
            "Alt, Return, fullscreen," # toggle the window between focus and fullscreen

            "$mainMod, Return, exec, $term" # launch terminal emulator
            "$mainMod, F, exec, $file" # launch file manager
            "$mainMod, B, exec, $browser" # launch file manager
            "$mainMod, E, exec, $editor" # launch text editor
            "Ctrl+Shift, Escape, exec, $sysmon" # launch system monitor (htop/btop or fallback to top)
            # "Ctrl+Shift+Alt, Delete, exec, pkill wlogout || wlogout -p layer-shell"

            "$mainMod+Shift, Tab, exec, pkill fuzzel || fuzzel" # launch application launcher
            "$mainMod, D, exec, pkill fuzzel || cliphist list | fuzzel  --match-mode fzf --dmenu | cliphist decode | wl-copy" # Clipboard history >> clipboard
            # "$mainMod, Comma, exec, pkill fuzzel || fuzzel-emoji" # Pick emoji >> clipboard
            # "$mainMod+Alt, L, exec, hyprlock-background"
            # ''$mainMod+Shift, O, exec, XDG_CURRENT_DESKTOP="gnome" gnome-control-center ''
            # "$mainMod+Shift, C, exec, hyprpicker -a"

            # Ags
            # "$mainMod, Tab, exec, ags -t 'overview'"
            # "$mainMod+Ctrl, T, exec, ~/.config/ags/scripts/color_generation/switchwall.sh"
            # "Ctrl+Alt, Slash, exec, ags run-js 'cycleMode();'"

            # Screen record
            # "$mainMod+Alt, R, exec, ~/.config/ags/scripts/record-script.sh"
            # "$mainMod+Shift+Alt, R, exec, ~/.config/ags/scripts/record-script.sh --fullscreen-sound"
            # "$mainMod+Ctrl+Alt, R, exec, ~/.config/ags/scripts/record-script.sh --fullscreen"

            # Screenshots
            # ''$mainMod+Ctrl+Shift, P,exec, grim -g "$(slurp $SLURP_ARGS)" "tmp.png" && tesseract -l eng "tmp.png" - | wl-copy && rm"tmp.png" ''
            # ''$mainMod+Shift+Alt, S, exec, grim -g"$(slurp)" - | swappy -f - ''
            # ''$mainMod+Shift+Alt, P, exec, ~/.config/ags/scripts/grimblast.sh --freeze copy area''
            # ''$mainMod+Alt, S, exec, mkdir -p ~/Pictures/Screenshots && ~/.config/ags/scripts/grimblast.sh copysave screen ~/Pictures/Screenshots/Screenshot_"$(date '+%Y-%m-%d_%H.%M.%S')".png ''
            # '', Print, exec, mkdir -p ~/Pictures/Screenshots && ~/.config/ags/scripts/grimblast.sh copysave screen ~/Pictures/Screenshots/Screenshot_"$(date '+%Y-%m-%d_%H.%M.%S')".png ''

            # "$mainMod, I, exec, ags -t 'sideright'"
            # "$mainMod, M, exec, ags -t 'sideleft'"

            # "$mainMod, Period, exec, ags run-js 'openColorScheme.value = true; Utils.timeout(2000, () => openColorScheme.value = false);'"
            # "$mainMod+Shift, M, exec, ags run-js 'openMusicControls.value = (!mpris.getPlayer() ? false : !openMusicControls.value);'"
            "$mainMod+Shift, <, exec, playerctl volume 0.1-"
            "$mainMod+Shift, >, exec, playerctl volume 0.1+"
            "$mainMod+Shift, K, exec, playerctl play-pause"
            "$mainMod+Shift, J, exec, playerctl previous"
            ''$mainMod+Shift, L, exec, playerctl next || playerctl position `bc <<< "100 * $(playerctl metadata mpris:length) / 1000000 / 100"` ''

            # Reload ags and/or hyprland
            "$mainMod+Ctrl+Shift, R, exec, hyprctl reload; killall ags ydotool; ags &"
            # "$mainMod+Ctrl, R, exec, killall ags ydotool; ags &"

            # Not working current
            # "Ctrl+Super, L, exec, ags run-js 'lock.lock()'"
            # ''Super, Slash, exec, for ((i=0; i<$(hyprctl monitors -j | jq length); i++)); do ags -t "cheatsheet""$i"; done ''
            # ''Ctrl+Super, G, exec, for ((i=0; i<$(hyprctl monitors -j | jq length); i++)); do ags -t"crosshair""$i"; done ''
            # ''Ctrl+Alt, Delete, exec, for ((i=0; i<$(hyprctl monitors -j | jq length); i++)); do ags -t"session""$i"; done''
            # ''Super, K, exec, for ((i=0; i<$(hyprctl monitors -j | jq length); i++)); do ags -t"osk""$i"; done ''

            # Change window focus
            "$mainMod, H, movefocus, l"
            "$mainMod, J, movefocus, d"
            "$mainMod, K, movefocus, u"
            "$mainMod, L, movefocus, r"
            "Alt, Tab, bringactivetotop"
            "Alt, Tab, cyclenext"

            # Move windows
            "$mainMod+Ctrl, H, movewindow, l"
            "$mainMod+Ctrl, J, movewindow, r"
            "$mainMod+Ctrl, K, movewindow, u"
            "$mainMod+Ctrl, L, movewindow, d"

            # Switch workspaces
            # "$mainMod, 1, exec, ~/.config/ags/scripts/hyprland/workspace_action.sh workspace 1"
            # "$mainMod, 2, exec, ~/.config/ags/scripts/hyprland/workspace_action.sh workspace 2"
            # "$mainMod, 3, exec, ~/.config/ags/scripts/hyprland/workspace_action.sh workspace 3"
            # "$mainMod, 4, exec, ~/.config/ags/scripts/hyprland/workspace_action.sh workspace 4"
            # "$mainMod, 5, exec, ~/.config/ags/scripts/hyprland/workspace_action.sh workspace 5"
            # "$mainMod, 6, exec, ~/.config/ags/scripts/hyprland/workspace_action.sh workspace 6"
            # "$mainMod, 7, exec, ~/.config/ags/scripts/hyprland/workspace_action.sh workspace 7"
            # "$mainMod, 8, exec, ~/.config/ags/scripts/hyprland/workspace_action.sh workspace 8"
            # "$mainMod, 9, exec, ~/.config/ags/scripts/hyprland/workspace_action.sh workspace 9"
            # "$mainMod, 0, exec, ~/.config/ags/scripts/hyprland/workspace_action.sh workspace 10"

            # Move focused window to a workspace
            # "$mainMod+Shift, 1, exec, ~/.config/ags/scripts/hyprland/workspace_action.sh movetoworkspace 1"
            # "$mainMod+Shift, 2, exec, ~/.config/ags/scripts/hyprland/workspace_action.sh movetoworkspace 2"
            # "$mainMod+Shift, 3, exec, ~/.config/ags/scripts/hyprland/workspace_action.sh movetoworkspace 3"
            # "$mainMod+Shift, 4, exec, ~/.config/ags/scripts/hyprland/workspace_action.sh movetoworkspace 4"
            # "$mainMod+Shift, 5, exec, ~/.config/ags/scripts/hyprland/workspace_action.sh movetoworkspace 5"
            # "$mainMod+Shift, 6, exec, ~/.config/ags/scripts/hyprland/workspace_action.sh movetoworkspace 6"
            # "$mainMod+Shift, 7, exec, ~/.config/ags/scripts/hyprland/workspace_action.sh movetoworkspace 7"
            # "$mainMod+Shift, 8, exec, ~/.config/ags/scripts/hyprland/workspace_action.sh movetoworkspace 8"
            # "$mainMod+Shift, 9, exec, ~/.config/ags/scripts/hyprland/workspace_action.sh movetoworkspace 9"
            # "$mainMod+Shift, 0, exec, ~/.config/ags/scripts/hyprland/workspace_action.sh movetoworkspace 10"

            # "$mainMod+Shift+Ctrl, 1, exec, ~/.config/ags/scripts/hyprland/workspace_action.sh movetoworkspacesilent 1"
            # "$mainMod+Shift+Ctrl, 2, exec, ~/.config/ags/scripts/hyprland/workspace_action.sh movetoworkspacesilent 2"
            # "$mainMod+Shift+Ctrl, 3, exec, ~/.config/ags/scripts/hyprland/workspace_action.sh movetoworkspacesilent 3"
            # "$mainMod+Shift+Ctrl, 4, exec, ~/.config/ags/scripts/hyprland/workspace_action.sh movetoworkspacesilent 4"
            # "$mainMod+Shift+Ctrl, 5, exec, ~/.config/ags/scripts/hyprland/workspace_action.sh movetoworkspacesilent 5"
            # "$mainMod+Shift+Ctrl, 6, exec, ~/.config/ags/scripts/hyprland/workspace_action.sh movetoworkspacesilent 6"
            # "$mainMod+Shift+Ctrl, 7, exec, ~/.config/ags/scripts/hyprland/workspace_action.sh movetoworkspacesilent 7"
            # "$mainMod+Shift+Ctrl, 8, exec, ~/.config/ags/scripts/hyprland/workspace_action.sh movetoworkspacesilent 8"
            # "$mainMod+Shift+Ctrl, 9, exec, ~/.config/ags/scripts/hyprland/workspace_action.sh movetoworkspacesilent 9"
            # "$mainMod+Shift+Ctrl, 0, exec, ~/.config/ags/scripts/hyprland/workspace_action.sh movetoworkspacesilent 10"

            # Move focused window to a relative workspace
            "$mainMod+Shift, bracketright, movetoworkspace, r+1"
            "$mainMod+Shift, bracketleft, movetoworkspace, r-1"

            # Move/Switch to special workspace (scratchpad)
            "$mainMod, S, togglespecialworkspace,"
            "$mainMod+Shift, S, movetoworkspace, special"
            "$mainMod+Shift+Ctrl, S, movetoworkspacesilent, special"
          ]
          # --- Ax-Shell Integration ---
          ++ (mkIf (axshellCfg.enable) axshellSettings.hyprlandBinds);

        binde = [
          # Resize windows
          "$mainMod+Shift, H, resizeactive, -30 0" # left
          "$mainMod+Shift, J, resizeactive, 0 30" # down
          "$mainMod+Shift, K, resizeactive, 0 -30" # up
          "$mainMod+Shift, L, resizeactive, 30 0" # right

          # Switch workspaces to a relative workspace
          "$mainMod, bracketright, workspace, r+1"
          "$mainMod, bracketleft, workspace, r-1"

          "$mainMod+Shift, Comma, exec,  adjust-volume -0.05"
          "$mainMod+Shift, Period, exec, adjust-volume 0.05"
        ];

        bindlr = [
          "$mainMod, Space, exec, kbdswitch" # switch keyboard layout
        ];

        bindl = [
          ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_SINK@ toggle" # toggle audio mute
          # ", XF86AudioMute, exec, ags run-js 'indicator.popup(1);'"
          ", XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_SOURCE@ toggle" # toggle microphone mute
          # "$mainMod+Shift, V, exec, ags run-js 'indicator.popup(1);'"
        ];

        bindel = [
          ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_SINK@ 5%+" # increase volume
          ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_SINK@ 5%-" # decrease volume
          ", XF86MonBrightnessUp, exec, brightnessctl s 5%+"
          ", XF86MonBrightnessDown, exec, brightnessctl s 5%-"
        ];

        bindm = [
          # Scroll through existing workspaces
          # "$mainMod, mouse_down, workspace e+1"
          # "$mainMod, mouse_up, workspace e-1"

          # Move/Resize focused window
          "$mainMod, Z, movewindow"
          "$mainMod, X, resizewindow"
        ];

        exec-once =
          [
            # █░░ ▄▀█ █░█ █▄░█ █▀▀ █░█
            # █▄▄ █▀█ █▄█ █░▀█ █▄▄ █▀█

            # See https://wiki.hyprland.org/Configuring/Keywords/

            "wl-paste --type text --watch cliphist store" # clipboard store text data
            "wl-paste --type image --watch cliphist store" # clipboard store image data

            "swww-daemon --format xrgb" # wallpapers daemon

            # # Core components (authentication, lock screen, notification daemon)
            "dbus-update-activation-environment --all"

            # # Audio
            "easyeffects --gapplication-service"
          ]
          # Merge Ax-Shell's startup commands with your own.
          ++ (mkIf (axshellCfg.enable) axshellSettings.hyprlandExecOnce);
      };
    };
  };
}
