{ lib, inputs, ... }: let
  flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
in {

  nix = {
    settings = {
      auto-optimise-store = lib.mkDefault true;
      experimental-features = [ "nix-command" "flakes" ]; # Enable flakes support
      warn-dirty = false;
    };

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than +3";
    };

    registry = lib.mapAttrs (_: flake: { inherit flake;}) flakeInputs;
    nixPath = lib.mapAttrsToList (n: _: "${n}=flake:${n}") flakeInputs;
  };

}
