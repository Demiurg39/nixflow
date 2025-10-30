{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  cfg = config.modules.services.polkit;
in {
  options.modules.services.polkit = {
    enable = mkEnableOption "TODO";
  };

  config = mkIf (cfg.enable) {
    environment.systemPackages = with pkgs; [polkit_gnome];

    systemd.user.services.polkit-gnome-authentication-agent-1 = {
      description = "polkit-gnome-authentication-agent-1";
      wantedBy = ["graphical-session.target"];
      wants = ["graphical-session.target"];
      after = ["graphical-session.target"];
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
    };

    security.polkit.enable = true;
  };
}
