{
  config,
  inputs,
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./nh.nix
    ./nix-ld.nix
  ];

  environment.systemPackages = [pkgs.git];

  nix = let
    flakeInputs = lib.filterAttrs (_: v: lib.isType "flake" v) inputs;
  in {
    package = pkgs.lix;

    # pin the registry to avoid downloading and evaling a new nixpkgs version every time
    registry = lib.mapAttrs (_: v: {flake = v;}) flakeInputs;

    # set the path for channels compat
    nixPath = lib.mapAttrsToList (key: _: "${key}=flake:${key}") config.nix.registry;

    settings = {
      auto-optimise-store = lib.mkDefault true;
      experimental-features = ["nix-command" "flakes"]; # Enable flakes support
      warn-dirty = false;
      flake-registry = "/etc/nix/registry.json";

      trusted-users = ["root" "@wheel"];
    };
  };

  nixpkgs.config.allowUnfree = true;
}
