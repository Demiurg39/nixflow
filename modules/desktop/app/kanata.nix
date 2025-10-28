{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.modules.desktop.app.kanata;
in {
  options.modules.desktop.app.kanata = {
    enable = mkEnableOption "Enable kanata remapping";
  };

  config = mkIf (cfg.enable) {
    services.kanata = {
      enable = true;
      keyboards.default = {
        configFile = "${config.flake.configDir}/kanata/main.kbd";
      };
    };
  };
}
