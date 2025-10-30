{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  cfg = config.modules.development.database.postgres;
in {
  options.modules.development.database.postgres = {
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
