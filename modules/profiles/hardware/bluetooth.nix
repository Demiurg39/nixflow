{
  config,
  lib,
  ...
}:
with lib; let
  hardware = config.profiles.hardware;
in
  mkIf (any (mod: hasPrefix "bluetooth" mod) hardware) {
    hardware.bluetooth = {
      enable = true;
      powerOnBoot = false;
    };
  }
