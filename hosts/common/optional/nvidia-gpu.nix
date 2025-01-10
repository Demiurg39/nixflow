{ config, lib, ... }: let
  nvidiaPackage = config.hardware.nvidia.package;
in {
  services.xserver.videoDrivers = lib.mkDefault [ "nvidia" ];

  hardware.nvidia = {
    modesetting.enable = lib.mkDefault true;

    # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
    # Enable this if you have graphical corruption issues or application crashes after waking
    # Cause unsuspend trouble on open driver
    # powerManagement.enable = true;

    # Fine-grained power management. Turns off GPU when not in use.
    powerManagement.finegrained = true;

    # Use the NVidia open source kernel module
    # enable the open source drivers if the package supports it
    open = true;

    # Enable the Nvidia settings menu
    nvidiaSettings = false;

    # Select the appropriate driver version for your specific GPU.
    package = config.boot.kernelPackages.nvidiaPackages.stable;

    prime = {
      offload = {
        enable = true;
        enableOffloadCmd = true;
      };

      amdgpuBusId = "PCI:05:0:0";
      nvidiaBusId = "PCI:01:0:0";
    };
  };
}
