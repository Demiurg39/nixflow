{
  inputs,
  pkgs,
  ...
}: let
  inherit (inputs) nix-homebrew;
  inherit (inputs) homebrew-core;
  inherit (inputs) homebrew-cask;
in {
  imports = [
    inputs.nix-homebrew.darwinModules.nix-homebrew
  ];

  nix-homebrew = {
    # Install Homebrew under the default prefix
    enable = true;

    # Apple Silicon Only: Also install Homebrew under the default Intel prefix for Rosetta 2
    # enableRosetta = if pkgs.system true;
    enableRosetta = true;

    user = "demi";

    # Optional: Declarative tap management
    taps = {
      "homebrew/homebrew-core" = homebrew-core;
      "homebrew/homebrew-cask" = homebrew-cask;
    };
  };
}
