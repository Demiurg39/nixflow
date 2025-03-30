{pkgs, ...}: {
  environment.systemPackages = [pkgs.localsend];

  # for finding another devices
  networking.firewall.allowedTCPPorts = [53317];
}
