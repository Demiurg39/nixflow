{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  cfg = config.modules.development.databases.postgresql.pgadmin;
  postgresCfg = config.modules.development.databases.postgresql;
  initialEmail = "admin@email.com";
in {
  options.modules.development.databases.postgresql.pgadmin = {
    enable = mkEnableOption "TODO";
  };
  config = mkIf (cfg.enable && postgresCfg.enable) {
    services = {
      pgadmin = {
        enable = true;
        initialEmail = initialEmail;
        initialPasswordFile = config.age.secrets.pgadmin_pass.path;
        openFirewall = true;
        settings = {
          ALLOWED_HOSTS = ["127.0.0.1" "localhost" "192.168.0.0/16"];
          "CONFIG_DATABASE_URI" = "postgresql://pgadmin:pgadmin@localhost/pgadmin";
        };
      };
      postgresql = {
        authentication = ''
          local all pgadmin peer
        '';
        initialScript = pkgs.writeText "backend-initScript" ''
          CREATE ROLE pgadmin WITH PASSWORD 'pgadmin' SUPERUSER CREATEROLE CREATEDB REPLICATION BYPASSRLS LOGIN;
          CREATE DATABASE pgadmin;
          GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO pgadmin;
          GRANT ALL PRIVILEGES ON DATABASE postgres TO pgadmin;
          GRANT ALL PRIVILEGES ON DATABASE pgadmin TO pgadmin;
        '';
      };
    };
    systemd.services.pgadmin = {
      wantedBy = lib.mkForce [];
    };
    # assertions = [
    #   {
    #     assertion = config.modules.development.database.postgres.enable;
    #     message = "postgres is not enabled!";
    #   }
    # ];
  };
}
