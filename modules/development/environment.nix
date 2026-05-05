{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  cfg = config.modules.development.environment;
in {
  options.modules.development.environment = with types; {
    enable = mkEnableOption "Whether to enable devenv environment manager";
  };
  config = mkIf (cfg.enable) {
    environment.systemPackages = [
      pkgs.devenv
    ];
  };
}
