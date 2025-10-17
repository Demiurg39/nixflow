{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  cfg = config.modules.desktop.browsers.qutebrowser;
in {
  options.modules.desktop.browsers.qutebrowser = {
    enable = mkEnableOption "Enable qutebrowser";
  };

  config = mkIf (cfg.enable) {
    #TODO: add declarative config for qutebrowser
    environment.systemPackages = [pkgs.qutebrowser];
  };
}
