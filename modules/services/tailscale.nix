{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.modules.services.tailscale;
in {
  options.modules.services.tailscale = {
    enable = mkEnableOption "TODO";
  };

  config = mkIf (cfg.enable) {
    services.tailscale = {
      enable = true;
      openFirewall = true;
    };
  };
}
