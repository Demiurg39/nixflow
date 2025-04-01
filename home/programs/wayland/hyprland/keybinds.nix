{
  pkgs,
  self,
  ...
}: let
  kbdswitch = import "${self}/pkgs/bin/kbdswitch" {inherit pkgs;};
  adjust-volume = import "${self}/pkgs/bin/adjust-volume" {inherit pkgs;};
in {
  home.packages = [
    kbdswitch
    adjust-volume
  ];
  wayland.windowManager.hyprland.settings = {
    # Main modifier
    "$mainMod" = "Super"; # super / meta / windows key

    # Assign apps
    "$term" = "kitty";
    "$editor" = "neovide";
    "$file" = "nemo";
    "$browser" = "librewolf";
    "$sysmon" = "missioncenter";

    bind = [
      "$mainMod, Q, exec, hyprctl dispatch killactive" # close focused window
      "Alt,F4, exec, hyprctl dispatch killactive" # close focused window
      "$mainMod+Shift+Alt, Delete, exit," # kill hyprland session
      "$mainMod, W, togglefloating," # toggle the window between focus and float
      "Alt, Return, fullscreen," # toggle the window between focus and fullscreen

      "$mainMod, Return, exec, $term" # launch terminal emulator
      "$mainMod, F, exec, $file" # launch file manager
      "$mainMod, B, exec, $browser" # launch file manager
      "$mainMod, U, exec, $editor" # launch text editor
      "Ctrl+Shift, Escape, exec, $sysmon" # launch system monitor (htop/btop or fallback to top)
      "Ctrl+Shift+Alt, Delete, exec, pkill wlogout || wlogout -p layer-shell"

      "$mainMod+Shift, Tab, exec, pkill fuzzel || fuzzel" # launch application launcher
      "$mainMod, D, exec, pkill fuzzel || cliphist list | fuzzel  --match-mode fzf --dmenu | cliphist decode | wl-copy" # Clipboard history >> clipboard
      "$mainMod, Comma, exec, pkill fuzzel || fuzzel-emoji" # Pick emoji >> clipboard
      "$mainMod+Alt, L, exec, hyprlock-background"
      ''$mainMod+Shift, O, exec, XDG_CURRENT_DESKTOP="gnome" gnome-control-center ''
      "$mainMod+Shift, C, exec, hyprpicker -a"

      # Ags
      "$mainMod, Tab, exec, ags -t 'overview'"
      "$mainMod+Ctrl, T, exec, ~/.config/ags/scripts/color_generation/switchwall.sh"
      "Ctrl+Alt, Slash, exec, ags run-js 'cycleMode();'"

      # Screen record
      "$mainMod+Alt, R, exec, ~/.config/ags/scripts/record-script.sh"
      "$mainMod+Shift+Alt, R, exec, ~/.config/ags/scripts/record-script.sh --fullscreen-sound"
      "$mainMod+Ctrl+Alt, R, exec, ~/.config/ags/scripts/record-script.sh --fullscreen"

      # Screenshots
      ''$mainMod+Ctrl+Shift+Alt, P,exec, grim -g "$(slurp $SLURP_ARGS)" "tmp.png" && tesseract -l eng "tmp.png" - | wl-copy && rm"tmp.png" ''
      ''$mainMod+Ctrl+Shift, P,exec, grim -g "$(slurp $SLURP_ARGS)" "tmp.png" && tesseract "tmp.png" - | wl-copy && rm"tmp.png" ''
      ''$mainMod+Shift+Alt, S, exec, grim -g"$(slurp)" - | swappy -f - ''
      ''$mainMod+Shift+Alt, P, exec, ~/.config/ags/scripts/grimblast.sh --freeze copy area''
      ''$mainMod+Alt, P, exec, mkdir -p ~/Pictures/Screenshots && ~/.config/ags/scripts/grimblast.sh copysave screen ~/Pictures/Screenshots/Screenshot_"$(date '+%Y-%m-%d_%H.%M.%S')".png ''
      ''$mainMod, Print, exec, mkdir -p ~/Pictures/Screenshots && ~/.config/ags/scripts/grimblast.sh copysave screen ~/Pictures/Screenshots/Screenshot_"$(date '+%Y-%m-%d_%H.%M.%S')".png ''

      "$mainMod, I, exec, ags -t 'sideright'"
      "$mainMod, M, exec, ags -t 'sideleft'"

      "$mainMod, Period, exec, ags run-js 'openColorScheme.value = true; Utils.timeout(2000, () => openColorScheme.value = false);'"
      "$mainMod+Shift, M, exec, ags run-js 'openMusicControls.value = (!mpris.getPlayer() ? false : !openMusicControls.value);'"
      "$mainMod+Shift, K, exec, playerctl play-pause"
      "$mainMod+Shift, J, exec, playerctl previous"
      ''$mainMod+Shift, L, exec, playerctl next || playerctl position `bc <<< "100 * $(playerctl metadata mpris:length) / 1000000 / 100"` ''

      # Reload ags and/or hyprland
      "$mainMod+Ctrl+Shift, R, exec, hyprctl reload; killall ags ydotool; ags &"
      "$mainMod+Ctrl, R, exec, killall ags ydotool; ags &"

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
      "$mainMod, 1, exec, ~/.config/ags/scripts/hyprland/workspace_action.sh workspace 1"
      "$mainMod, 2, exec, ~/.config/ags/scripts/hyprland/workspace_action.sh workspace 2"
      "$mainMod, 3, exec, ~/.config/ags/scripts/hyprland/workspace_action.sh workspace 3"
      "$mainMod, 4, exec, ~/.config/ags/scripts/hyprland/workspace_action.sh workspace 4"
      "$mainMod, 5, exec, ~/.config/ags/scripts/hyprland/workspace_action.sh workspace 5"
      "$mainMod, 6, exec, ~/.config/ags/scripts/hyprland/workspace_action.sh workspace 6"
      "$mainMod, 7, exec, ~/.config/ags/scripts/hyprland/workspace_action.sh workspace 7"
      "$mainMod, 8, exec, ~/.config/ags/scripts/hyprland/workspace_action.sh workspace 8"
      "$mainMod, 9, exec, ~/.config/ags/scripts/hyprland/workspace_action.sh workspace 9"
      "$mainMod, 0, exec, ~/.config/ags/scripts/hyprland/workspace_action.sh workspace 10"

      # Move focused window to a workspace
      "$mainMod+Shift, 1, exec, ~/.config/ags/scripts/hyprland/workspace_action.sh movetoworkspace 1"
      "$mainMod+Shift, 2, exec, ~/.config/ags/scripts/hyprland/workspace_action.sh movetoworkspace 2"
      "$mainMod+Shift, 3, exec, ~/.config/ags/scripts/hyprland/workspace_action.sh movetoworkspace 3"
      "$mainMod+Shift, 4, exec, ~/.config/ags/scripts/hyprland/workspace_action.sh movetoworkspace 4"
      "$mainMod+Shift, 5, exec, ~/.config/ags/scripts/hyprland/workspace_action.sh movetoworkspace 5"
      "$mainMod+Shift, 6, exec, ~/.config/ags/scripts/hyprland/workspace_action.sh movetoworkspace 6"
      "$mainMod+Shift, 7, exec, ~/.config/ags/scripts/hyprland/workspace_action.sh movetoworkspace 7"
      "$mainMod+Shift, 8, exec, ~/.config/ags/scripts/hyprland/workspace_action.sh movetoworkspace 8"
      "$mainMod+Shift, 9, exec, ~/.config/ags/scripts/hyprland/workspace_action.sh movetoworkspace 9"
      "$mainMod+Shift, 0, exec, ~/.config/ags/scripts/hyprland/workspace_action.sh movetoworkspace 10"

      "$mainMod+Shift+Ctrl, 1, exec, ~/.config/ags/scripts/hyprland/workspace_action.sh movetoworkspacesilent 1"
      "$mainMod+Shift+Ctrl, 2, exec, ~/.config/ags/scripts/hyprland/workspace_action.sh movetoworkspacesilent 2"
      "$mainMod+Shift+Ctrl, 3, exec, ~/.config/ags/scripts/hyprland/workspace_action.sh movetoworkspacesilent 3"
      "$mainMod+Shift+Ctrl, 4, exec, ~/.config/ags/scripts/hyprland/workspace_action.sh movetoworkspacesilent 4"
      "$mainMod+Shift+Ctrl, 5, exec, ~/.config/ags/scripts/hyprland/workspace_action.sh movetoworkspacesilent 5"
      "$mainMod+Shift+Ctrl, 6, exec, ~/.config/ags/scripts/hyprland/workspace_action.sh movetoworkspacesilent 6"
      "$mainMod+Shift+Ctrl, 7, exec, ~/.config/ags/scripts/hyprland/workspace_action.sh movetoworkspacesilent 7"
      "$mainMod+Shift+Ctrl, 8, exec, ~/.config/ags/scripts/hyprland/workspace_action.sh movetoworkspacesilent 8"
      "$mainMod+Shift+Ctrl, 9, exec, ~/.config/ags/scripts/hyprland/workspace_action.sh movetoworkspacesilent 9"
      "$mainMod+Shift+Ctrl, 0, exec, ~/.config/ags/scripts/hyprland/workspace_action.sh movetoworkspacesilent 10"

      # Move focused window to a relative workspace
      "$mainMod+Shift, bracketright, movetoworkspace, r+1"
      "$mainMod+Shift, bracketleft, movetoworkspace, r-1"

      # Move/Switch to special workspace (scratchpad)
      "$mainMod, S, togglespecialworkspace,"
      "$mainMod+Shift, S, movetoworkspace, special"
      "$mainMod+Shift+Ctrl, S, movetoworkspacesilent, special"
    ];

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
      ", XF86AudioMute, exec, ags run-js 'indicator.popup(1);'"
      ", XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_SOURCE@ toggle" # toggle microphone mute
      "$mainMod+Shift, V, exec, ags run-js 'indicator.popup(1);'"
    ];

    bindel = [
      ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_SINK@ 5%+" # increase volume
      ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_SINK@ 5%-" # decrease volume
      ", XF86MonBrightnessDown, exec, ags run-js 'brightness.screen_value -= 0.05; indicator.popup(1);'"
      ", XF86MonBrightnessUp, exec, ags run-js 'brightness.screen_value += 0.05; indicator.popup(1);'"
    ];

    bindm = [
      # Scroll through existing workspaces
      "$mainMod, mouse_down, workspace e+1"
      "$mainMod, mouse_up, workspace e-1"

      # Move/Resize focused window
      "$mainMod, mouse:272, movewindow"
      "$mainMod, mouse:273, resizewindow"
      "$mainMod, Z, movewindow"
      "$mainMod, X, resizewindow"
    ];
  };
}
