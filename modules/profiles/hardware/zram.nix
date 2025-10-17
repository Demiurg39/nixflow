{
  config,
  lib,
  ...
}:
with lib; let
  hardware = config.modules.profiles.hardware;
in
  mkIf (any (mod: hasPrefix "zram" mod) hardware) {
    # zramSwap uses defaults, creating an (50% of RAM by defaut) device
    # The high priority ensures it's used before the disk swap.
    zramSwap = {
      enable = true;
      algorithm = "lz4";
      priority = 999;
    };

    # A swap file on disk acts as a safety net.
    # The low priority ensures it's used last for swapping
    swapDevices = [
      {
        device = "/var/swapfile";
        size = 4096;
        priority = -1;
      }
    ];
  }
