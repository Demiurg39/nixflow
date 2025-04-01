{pkgs, ...}: let
  lock = "${pkgs.systemd}/bin/loginctl lock-session";
in {
  services.hypridle = {
    enable = true;
    settings = {
      general = {
        lock_cmd = "pidof hyprlock || hypridle-background";
        before_sleep_cmd = "loginctl lock-session";
      };

      listener = [
        {
          timeout = 180;
          on-timeout = "brightnessctl -s set 10";
          on-resume = "brightnessctl -r";
        }
        {
          timeout = 180;
          on-timeout = "brightnessctl -sd asus::kbd_backlight set 0";
          on-resume = "brightnessctl -rd asus::kbd_backlight";
        }
        {
          timeout = 300;
          on-timeout = lock;
        }
        {
          timeout = 480;
          on-timeout = "hyprctl dispatch dpms off";
          on-resume = "hyprctl dispatch dpms on";
        }
        {
          timeout = 500;
          on-timeout = "pidof steam || systemctl suspend || loginctl suspend";
        }
      ];
    };
  };
}
