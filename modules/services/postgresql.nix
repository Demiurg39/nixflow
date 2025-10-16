{
  config,
  pkgs,
  lib,
  ...
}: let
  initialEmail = "admin@email.com";
in {
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
        local all all trust
      '';
      enable = true;
      initialScript = pkgs.writeText "backend-initScript" ''
        CREATE ROLE pgadmin WITH PASSWORD 'pgadmin' SUPERUSER CREATEROLE CREATEDB REPLICATION BYPASSRLS LOGIN;
        CREATE DATABASE pgadmin;
        GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO pgadmin;
        GRANT ALL PRIVILEGES ON DATABASE postgres TO pgadmin;
        GRANT ALL PRIVILEGES ON DATABASE pgadmin TO pgadmin;
      '';
      package = pkgs.postgresql_17;
    };
  };
  systemd.services.pgadmin = {
    wantedBy = lib.mkForce [];
  };
}
