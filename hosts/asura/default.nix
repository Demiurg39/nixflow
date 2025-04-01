{pkgs, ...}: {
  imports = [
    ./hardware-configuration.nix
  ];

  # nh default flake
  environment.variables.FLAKE = "/home/demi/nixflow";

  console.keyMap = "mod-dh-ansi-us";

  # for SSD/NVME health
  services.fstrim.enable = true;

  # hostname
  networking.hostName = "asura";

  system.stateVersion = "24.11"; # Do not touch
}
