{pkgs, ...}: {
  boot = {
    bootspec.enable = true;

    # use latest kernel
    kernelPackages = pkgs.linuxPackages_latest;

    # kernelParams = [
    #   "quiet"
    #   "systemd.show_status=auto"
    #   "rd.udev.log_level=3"
    # ];

    loader = {
      grub = {
        enable = true;
        efiSupport = true;
        device = "nodev";
      };
    };

    plymouth = {
      enable = false;
    };
  };
}
