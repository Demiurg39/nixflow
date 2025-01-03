{

  description = "My system configuration flake";

  inputs = {
    #nixpkgs-stable.url = "github:nixos/nixpkgs/nixpkgs-24.11";

    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "github:hyprwm/Hyprland";
  };

  outputs = { self, nixpkgs, ... }@inputs: let
    inherit (inputs) home-manager;
    system = "x86_64-linux";
    pkgs = import nixpkgs { inherit system; config.allowUnfree = true; };
  in {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = system;
      specialArgs = { inherit inputs system pkgs; };
      modules = [ ./nixos/configuration.nix ];
    };

    # homeConfigurations.demi = home-manager.lib.homeManagerConfiguration {
    #   inherit pkgs;
    #   modules = [ ./home-manager/home.nix ];
    # };
  };

}
