{
  config,
  lib,
  ...
}:
with lib; let
  hardware = config.modules.profiles.hardware;
in
  mkIf (any (mod: hasPrefix "cpu/amd" mod) hardware) {
    hardware.cpu.amd.updateMicrocode = mkDefault config.hardware.enableRedistributableFirmware;

    # performance scaling for modern AMD processors
    # allows more efficient frequency management
    boot.kernelParams = ["amd_pstate=active"]; # For Linux 6.3+
    boot.kernelModules = ["kvm-amd"];
  }
