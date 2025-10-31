{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  cfg = config.modules.desktop.programs;
in {
  options.modules.desktop.programs = {
    telegram = {enable = mkEnableOption "TODO";};
    ayugram = {enable = mkEnableOption "TODO";};
  };

  config = mkIf (cfg.telegram.enable || cfg.ayugram.enable) {
    environment.systemPackages =
      if cfg.ayugram.enable
      then [pkgs.ayugram-desktop]
      else [pkgs.telegram-desktop];
  };
}
