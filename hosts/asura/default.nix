{...}: {
  imports = [
    ./hardware-configuration.nix
    ./secrets.nix
  ];

  # TODO: move this somewhere more suited for this
  # cause flake might be used not by just this host
  # maybe exporting it somewhere else
  # nh default flake
  # environment.variables.FLAKE = "/home/demi/nixflow";

  console.keyMap = "mod-dh-ansi-us";

  # for SSD/NVME health
  services.fstrim.enable = true;
}
