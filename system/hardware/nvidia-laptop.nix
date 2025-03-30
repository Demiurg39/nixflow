{
  config,
  lib,
  ...
}: {
  services.xserver.videoDrivers = lib.mkDefault ["nvidia"];

  hardware.nvidia = {
    modesetting.enable = lib.mkDefault true;

    # Fine-grained power management. Turns off GPU when not in use.
    powerManagement.finegrained = true;

    # Use the nvidia open source kernel module
    open = true;

    # Enable the Nvidia settings menu
    nvidiaSettings = false;

    # Select the driver version for specific GPU.
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
