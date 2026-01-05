# --- Arion --- tool for building and runnig multiple containers(docker, podman)
{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  cfg = config.modules.development.docker-compose;
in {
  options.modules.development.docker-compose = with types; {
    enable = mkEnableOption "Whether to enable docker compose wia arion";
  };
  config = mkIf (cfg.enable) {
    environment.systemPackages = [
      pkgs.arion
      pkgs.docker-client
      pkgs.podman-compose
    ];
    user.extraGroups = ["docker"];

    virtualisation.docker.enable = false;
    virtualisation.podman = {
      enable = true;
      dockerSocket.enable = true;
      defaultNetwork.settings.dns_enabled = true;
    };
  };
}
