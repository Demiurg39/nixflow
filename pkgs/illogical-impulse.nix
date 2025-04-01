{
  pkgs,
  ags,
  ...
}: let
  inherit (pkgs) lib;
in
  lib.fix (self: {
    illogical-impulse-ags = pkgs.callPackage ./illogical-impulse {};
    illogical-impulse-ags-launcher = pkgs.callPackage ./illogical-impulse/ags-launcher {inherit ags;};
    illogical-impulse-kvantum = pkgs.callPackage ./illogical-impulse/kvantum {};
    illogical-impulse-oneui4-icons = pkgs.callPackage ./illogical-impulse/oneui4-icons {};
  })
