{pkgs, ...}: {
  boot = {
    bootspec.enable = true;

    # use latest kernel
    kernelPackages = pkgs.linuxPackages_latest;

    kernelParams = [
      "quiet"
      "systemd.show_status=auto"
      "rd.udev.log_level=3"
    ];

    loader = {
      # systemd-boot on UEFI
      efi.canTouchEfiVariables = true;
      systemd-boot.enable = true;
      systemd-boot.configurationLimit = 5;
    };

    plymouth = {
      enable = false;
    };
  };
}
