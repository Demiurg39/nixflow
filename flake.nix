{
  description = "My system configuration flake";

  outputs = {
    nixpkgs,
    systems,
    self,
    ...
  } @ inputs: let
    eachSystem = nixpkgs.lib.genAttrs (import systems);
    lib = import ./lib {lib = nixpkgs.lib;};
  in {
    nixosConfigurations = import ./hosts {inherit inputs self lib nixpkgs;};

    nixosModules.modules = import ./modules;

    devShells = eachSystem (
      system: let
        pkgs = nixpkgs.legacyPackages.${system};
      in {
        default = import ./devshells/flakeShell.nix {inherit system inputs pkgs;};
      }
    );

    formatter = eachSystem (system: nixpkgs.legacyPackages.${system}.alejandra);
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    systems.url = "github:nix-systems/default";

    # pre-commit-hooks.url = "github:cachix/pre-commit-hooks.nix";
    # pre-commit-hooks.inputs.nixpkgs.follows = "nixpkgs";

    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.darwin.follows = "";
    };

    # disko.url = "github:nix-community/disko";
    # disko.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    hyprland.url = "github:hyprwm/Hyprland";
    hyprland.inputs.nixpkgs.follows = "nixpkgs";

    # lanzaboote.url = "github:nix-community/lanzaboote";
    # lanzaboote.inputs.nixpkgs.follows = "nixpkgs";

    # nivix.url = "github:demiurg39/nivix";
    # nivix.inputs.nixpkgs.follows = "nixpkgs";

    nvim-dots.url = "github:demiurg39/nvchad";
    nvim-dots.flake = false;

    nix4nvchad = {
      url = "github:nix-community/nix4nvchad";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.nvchad-starter.follows = "nvim-dots";
    };

    nix-flatpak.url = "github:gmodena/nix-flatpak";

    mango.url = "github:DreamMaoMao/mango";
    mango.inputs.nixpkgs.follows = "nixpkgs";

    dms.url = "github:AvengeMedia/DankMaterialShell/stable";
    dms.inputs.nixpkgs.follows = "nixpkgs";

    niri.url = "github:sodiboo/niri-flake";
    niri.inputs.nixpkgs.follows = "nixpkgs";

    nix-index-database.url = "github:nix-community/nix-index-database";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";

    spicetify-nix.url = "github:Gerg-L/spicetify-nix";
    spicetify-nix.inputs.nixpkgs.follows = "nixpkgs";
    spicetify-nix.inputs.systems.follows = "systems";

    millennium.url = "github:SteamClientHomebrew/Millennium?dir=packages/nix";
  };
}
