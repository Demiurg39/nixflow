{pkgs, ...}: {
  services = {
    supergfxd.enable = true;

    asusd = {
      enable = true;
      enableUserService = true;
    };
  };

  systemd.services.supergfxd.path = [pkgs.pciutils];
}
