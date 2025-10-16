{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.desktop.app.syncthing;
in {
  options.desktop.app.syncthing = {
    enable = mkEnableOption "Enable syncthing";
  };

  config = mkIf (cfg.enable) {};
}
