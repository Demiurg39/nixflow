# --- Arion --- tool for building and runnig multiple containers(docker, podman)
{pkgs, ...}: {
  environment.systemPackages = [pkgs.arion pkgs.docker-client];

  virtualisation.docker.enable = false;
  virtualisation.podman = {
    enable = true;
    dockerSocket.enable = true;
    defaultNetwork.settings.dns_enabled = true;
  };
}
