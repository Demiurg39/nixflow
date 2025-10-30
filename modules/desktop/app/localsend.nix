{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.modules.desktop.app.localsend;
in {
  options.modules.desktop.app.localsend = {
    enable = mkEnableOption "TODO";
  };

  config = mkIf (cfg.enable) {
    programs.localsend = {
      enable = true;
      openFirewall = true;
    };
  };
}
