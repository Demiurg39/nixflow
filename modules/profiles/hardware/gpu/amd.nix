{
  config,
  lib,
  ...
}:
with lib; let
  hardware = config.modules.profiles.hardware;
in
  mkIf (any (mod: hasPrefix "gpu/amd" mod) hardware) {
    boot.initrd.kernelModules = ["amdgpu"];
    services.xserver.videoDrivers = mkBefore ["amdgpu"];

    # graphics drivers / HW accel
    hardware.graphics.enable = true;
    hardware.graphics.enable32Bit = true;

    user.extraGroups = ["video"];
  }
