{
  inputs,
  config,
  lib,
  ...
}:
with lib; let
  hardware = config.profiles.hardware;
in
  mkIf (any (mod: hasPrefix "security/lanzaboote" mod) hardware) {
    imports = [inputs.lanzaboote.nixosModules.lanzaboote];

    boot = {
      lanzaboote = {
        enable = true;
        pkiBundle = "/var/lib/sbctl";
      };

      # we let lanzaboote install systemd-boot
      loader.systemd-boot.enable = lib.mkForce false;
    };
  }
