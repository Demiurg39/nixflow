{

  # home.file = {
  #   ".local/bin".source = ./../../dotfiles/local/bin;
  # };

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
          # "$mainMod, Q, exec, $scrPath/dontkillsteam.sh" # close focused window
          "$mainMod, Q, exec, hyprctl dispatch killactive" # close focused window
          "Alt,F4, exec, hyprctl dispatch killactive" # close focused window
          "$mainMod, Delete, exit," # kill hyprland session
          "$mainMod, W, togglefloating," # toggle the window between focus and float
          "Alt, Return, fullscreen," # toggle the window between focus and fullscreen
          # "$mainMod, Home, exec, hyprlock" # launch lock screen FIXME
          # "$mainMod, Backspace, exec, $scrPath/logoutlaunch.sh" # launch logout menu FIXME
          # "Ctrl+Alt, W, exec, killall waybar || waybar" # toggle waybar

          "$mainMod, Return, exec, $term" # launch terminal emulator
          "$mainMod, L, exec, $file" # launch file manager 
          "$mainMod, F, exec, $browser" # launch file manager 
          "$mainMod, U, exec, $editor" # launch text editor
          "Ctrl+Shift, Escape, exec, $sysmon" # launch system monitor (htop/btop or fallback to top)

          "$mainMod, R, exec, pkill fuzzel || fuzzel" # launch application launcher FIXME
          "$mainMod, D, exec, pkill fuzzel || cliphist list | fuzzel  --match-mode fzf --dmenu | cliphist decode | wl-copy" # Clipboard history >> clipboard
          "$mainMod, Period, exec, pkill fuzzel || ~/.local/bin/fuzzel-emoji" # Pick emoji >> clipboard

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

          # Move focused window to a workspace
          "$mainMod+Shift, 1, movetoworkspace, 1"
          "$mainMod+Shift, 2, movetoworkspace, 2"
          "$mainMod+Shift, 3, movetoworkspace, 3"
          "$mainMod+Shift, 4, movetoworkspace, 4"
          "$mainMod+Shift, 5, movetoworkspace, 5"
          "$mainMod+Shift, 6, movetoworkspace, 6"
          "$mainMod+Shift, 7, movetoworkspace, 7"
          "$mainMod+Shift, 8, movetoworkspace, 8"
          "$mainMod+Shift, 9, movetoworkspace, 9"
          "$mainMod+Shift, 0, movetoworkspace, 10"
                                                                 
          # Move focused window to a relative workspace
          "$mainMod+Shift+Ctrl, bracketright, movetoworkspace, r+1"
          "$mainMod+Shift+Ctrl, bracketleft, movetoworkspace, r-1"


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
          # "$mainMod, Space, exec, $scrPath/kbdswitch.sh" # switch keyboard layout FIXME
          ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_SINK@ toggle" # toggle audio mute
          ", XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_SOURCE@ toggle" # toggle microphone mute
      ];

      bindel = [
          ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_SINK@ 5%+" # increase volume
          ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_SINK@ 5%-" # decrease volume
          ", XF86MonBrightnessUp, exec, brightnessctl s 10%+" # increase brightness
          ", XF86MonBrightnessDown, exec, brightnessctl s 10%-" # decrease brightness

		

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
