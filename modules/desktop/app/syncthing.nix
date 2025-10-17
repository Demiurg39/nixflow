{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.modules.desktop.app.syncthing;
in {
  options.modules.desktop.app.syncthing = {
    enable = mkEnableOption "Enable syncthing";
  };

  config = mkIf (cfg.enable) {};
}
