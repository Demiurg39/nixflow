{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  cfg = config.modules.desktop.terminal.programs.yazi;
  nushellCfg = config.modules.desktop.terminal.shells.nushell;
in {
  options.modules.desktop.terminal.programs.yazi = {
    enable = mkEnableOption "Whether to enable yazi";
  };

  config = mkIf (cfg.enable) {
    home.programs.yazi = {
      enable = true;
      enableNushellIntegration = nushellCfg.enable;
      shellWrapperName = "yy";
      extraPackages = with pkgs; [
        mediainfo
        exiftool
      ];
    };
  };
}
