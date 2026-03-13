{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  cfg = config.modules.development.databases.postgresql;
in {
  options.modules.development.databases.postgresql = {
    enable = mkEnableOption "TODO";
  };
  config = mkIf (cfg.enable) {
    services.postgresql = {
      authentication = ''
        local all all trust
      '';
      enable = true;
      package = pkgs.postgresql_17;
    };
  };
}
