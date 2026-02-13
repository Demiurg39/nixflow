{
  config,
  lib,
  ...
}:
with lib; let
  hardware = config.modules.profiles.hardware;
in
  mkIf (any (mod: hasPrefix "tablet" mod) hardware) {
    hardware.opentabletdriver.enable = true;
  }
