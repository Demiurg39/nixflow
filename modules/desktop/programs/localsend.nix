{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.modules.desktop.programs.localsend;
in {
  options.modules.desktop.programs.localsend = {
    enable = mkEnableOption "TODO";
  };

  config = mkIf (cfg.enable) {
    programs.localsend = {
      enable = true;
      openFirewall = true;
    };
  };
}
