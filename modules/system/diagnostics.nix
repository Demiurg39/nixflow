{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  cfg = config.modules.system.utils;
in {
  options.modules.system.utils = {
    enable = mkEnableOption "TODO";
  };

  config = mkIf (cfg.enable) {
    environment.systemPackages = with pkgs; [
      nvme-cli
      hdparm
      smartmontools
    ];
  };
}
