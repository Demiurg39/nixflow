{
  config,
  pkgs,
  lib,
  ...
}: {
  # greetd display manager
  services.greetd = let
    hyprland = "${lib.getExe config.programs.uwsm.package} start hyprland-uwsm.desktop";
    session = {
      command = "${lib.getExe pkgs.greetd.tuigreet} --time --remember --cmd '${hyprland}'";
      user = "demi";
    };
  in {
    enable = true;
    settings = {
      terminal.vt = 1;
      default_session = session;
      initial_session = session;
    };
  };

  programs.uwsm = {
    enable = true;
    waylandCompositors.hyprland = {
      binPath = "/run/current-system/sw/bin/Hyprland";
      prettyName = "Hyprland";
      comment = "Hyprland managed by UWSM";
    };
  };
}
