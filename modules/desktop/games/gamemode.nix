{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.modules.desktop.games.gamemode;
in {
  options.modules.desktop.games.gamemode = {
    enable = mkEnableOption "TODO";
  };

  config = mkIf (cfg.enable) {
    programs.gamemode = {
      enable = true;
      enableRenice = true;
      settings = {
        general = {
          softrealtime = "auto";
          renice = 10;
          inhibit_screensaver = 1;
          disable_splitlock = 1;
        };
      };
    };

    user.extraGroups = ["gamemode"];
  };
}
