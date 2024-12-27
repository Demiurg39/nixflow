{

  home.file = {
    ".local/bin".source = ./../.local/bin;
  };

  wayland.windowManager.hyprland.settings = {
      # Main modifier
      "$mainMod" = "Super"; # super / meta / windows key
      
      # Assign apps
      "$term" = "kitty";
      "$editor" = "neovide";
      "$file" = "nemo";
      "$browser" = "librewolf";

      bind = [
          # "$mainMod, Q, exec, $scrPath/dontkillsteam.sh" # close focused window
          "$mainMod, Q, exec, hyprctl dispatch killactive" # close focused window
          "Alt,F4, exec, $scrPath/dontkillsteam.sh" # close focused window
          "$mainMod, Delete, exit," # kill hyprland session
          "$mainMod, W, togglefloating," # toggle the window between focus and float
          "Alt, Return, fullscreen," # toggle the window between focus and fullscreen
          "$mainMod, Home, exec, hyprlock" # launch lock screen FIXME
          "$mainMod, Backspace, exec, $scrPath/logoutlaunch.sh" # launch logout menu FIXME
          "Ctrl+Alt, W, exec, killall waybar || waybar" # toggle waybar

          "$mainMod, Return, exec, $term" # launch terminal emulator
          "$mainMod, L, exec, $file" # launch file manager 
          "$mainMod, F, exec, $browser" # launch file manager 
          "$mainMod, U, exec, $editor" # launch text editor FIXME
          "Ctrl+Shift, Escape, exec, $scrPath/sysmonlaunch.sh" # launch system monitor (htop/btop or fallback to top) FIXME

          "$mainMod, R, exec, pkill fuzzel || fuzzel" # launch application launcher FIXME
          "Super, D, exec, pkill fuzzel || cliphist list | fuzzel  --match-mode fzf --dmenu | cliphist decode | wl-copy" # Clipboard history >> clipboard
          "Super, Period, exec, pkill fuzzel || ~/.local/bin/fuzzel-emoji" # Pick emoji >> clipboard

          # Move/Change window focus
          "$mainMod, M, movefocus, l"
          "$mainMod, N, movefocus, d"
          "$mainMod, E, movefocus, u"
          "$mainMod, I, movefocus, r"
          "Alt, Tab, movefocus, d"

          # Switch workspaces
          "$mainMod, 1, workspace, 1"
          "$mainMod, 2, workspace, 2"
          "$mainMod, 3, workspace, 3"
          "$mainMod, 4, workspace, 4"
          "$mainMod, 5, workspace, 5"
          "$mainMod, 6, workspace, 6"
          "$mainMod, 7, workspace, 7"
          "$mainMod, 8, workspace, 8"
          "$mainMod, 9, workspace, 9"
          "$mainMod, 0, workspace, 10"

          # Switch workspaces to a relative workspace
          "$mainMod+Ctrl, bracketright, workspace, r+1"
          "$mainMod+Ctrl, bracketleft, workspace, r-1"


          # Move/Switch to special workspace (scratchpad)
          "$mainMod+Shift, S, movetoworkspacesilent, special"
          "$mainMod, S, togglespecialworkspace,"
      ];
      
      binde = [
      # Resize windows
      "$mainMod+Shift, M, resizeactive, -30 0" # left
      "$mainMod+Shift, N, resizeactive, 0 30"  # down
      "$mainMod+Shift, E, resizeactive, 0 -30" # up
      "$mainMod+Shift, I, resizeactive, 30 0"  # right
      ];

      bindl = [
          "$mainMod, Space, exec, $scrPath/kbdswitch.sh" # switch keyboard layout FIXME
      ];

      bindel = [
          ", XF86MonBrightnessUp, exec, $scrPath/backlight.sh --inc" # increase brightness FIXME
          ", XF86MonBrightnessDown, exec, $scrPath/backlight.sh --dec" # decrease brightness FIXME
          ", XF86AudioMute, exec, $scrPath/volume.sh --toggle" # toggle audio mute
          ", XF86AudioMicMute, exec, $scrPath/volume.sh --toggle-mic" # toggle microphone mute
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
