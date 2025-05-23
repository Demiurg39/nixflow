{
  inputs,
  lib,
  ...
}: {
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
