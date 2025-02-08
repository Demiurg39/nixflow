{pkgs, ...}: {
  imports = [
    ./cliphist.nix
    ./fuzzel.nix
    ./kitty.nix
    ./wlogout.nix
    ./zathura.nix
  ];
}
