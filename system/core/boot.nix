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

    plymouth = {
      enable = false;
    };
  };
}
