{
  config,
  lib,
  ...
}:
with lib; let
  hardware = config.modules.profiles.hardware;
in
  mkIf (any (mod: hasPrefix "ssd" mod) hardware) {
    services.fstrim.enable = true;

    # gc kills ssds
    nix.gc.automatic = mkForce false;
  }
