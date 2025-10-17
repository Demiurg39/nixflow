{
  config,
  lib,
  ...
}:
with lib; let
  hardware = config.modules.profiles.hardware;
in
  mkIf (any (mod: hasPrefix "gpu/amd" mod) hardware) {
    # graphics drivers / HW accel
    hardware.graphics.enable = true;
    hardware.graphics.enable32Bit = true;
  }
