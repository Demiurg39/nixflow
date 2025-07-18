{self, ...}: let
  home = "${self}/home";
in {
  imports = [
    "${home}/editors/nvchad.nix"
  ];
}
