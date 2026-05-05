# --- Arion --- tool for building and runnig multiple containers(docker, podman)
{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  # TODO: rename it to just docker, or podman smth, and
  # fix any possible issues that might pop out
  cfg = config.modules.development.docker-compose;
  hasNvidia = any (mod: hasPrefix "gpu/nvidia" mod) config.modules.profiles.hardware;
in {
  options.modules.development.docker-compose = with types; {
    enable = mkEnableOption "Whether to enable docker compose wia arion";
  };
  config = mkIf (cfg.enable) {
    hardware.nvidia-container-toolkit.enable = hasNvidia;

    environment.systemPackages = [
      pkgs.arion
      pkgs.docker-client
      pkgs.podman-compose
    ];
    user.extraGroups = ["docker"];

    virtualisation.docker.enable = false;
    virtualisation.podman = {
      enable = true;
      dockerCompat = true;
      dockerSocket.enable = true;
      defaultNetwork.settings.dns_enabled = true;
    };
  };
}
