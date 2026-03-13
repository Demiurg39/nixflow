{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.modules.services.warp;
in {
  options.modules.services.warp = {
    enable = mkEnableOption "TODO";
  };

  config = mkIf (cfg.enable) {
    services.cloudflare-warp = {
      enable = true;
    };
  };
}
