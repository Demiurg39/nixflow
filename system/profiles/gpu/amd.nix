{
  config,
  lib,
  ...
}:
with lib; let
  hardware = config.profiles.hardware;
in
  mkIf (any (mod: hasPrefix "gpu/amd" mod) hardware) {
    # graphics drivers / HW accel
    hardware.graphics.enable = true;
    hardware.graphics.enable32Bit = true;
  }
