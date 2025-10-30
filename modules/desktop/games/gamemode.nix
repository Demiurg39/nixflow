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
      settings = {
        general = {
          softrealtime = "auto";
          renice = 15;
        };
      };
    };
  };
}
