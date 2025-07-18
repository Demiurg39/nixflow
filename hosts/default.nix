{
  self,
  inputs,
  ...
}: let
  inherit (inputs.nixpkgs.lib) nixosSystem;
  inherit (inputs.nix-darwin.lib) darwinSystem;

  homeImports = import "${self}/home/profiles";

  mod = "${self}/system";

  # get the basic config to build on top of
  inherit (import mod) desktop laptop;

  # get these into the module system
  specialArgs = {inherit inputs self;};
in {
  flake.nixosConfigurations = {
    asura = nixosSystem {
      inherit specialArgs;
      modules =
        laptop
        ++ [
          ./asura

          "${mod}/core/lanzaboote.nix"

          "${mod}/hardware/nvidia-laptop.nix"

          "${mod}/network/localsend.nix"

          "${mod}/programs/gamemode.nix"
          "${mod}/programs/gaming.nix"
          "${mod}/programs/hyprland"
          "${mod}/programs/adb.nix"

          "${mod}/services/kanata"
          "${mod}/services/syncthing.nix"

          {
            home-manager = {
              users.demi.imports = homeImports."demi@asura";
              extraSpecialArgs = specialArgs;
            };
          }
        ];
    };
  };
  flake.darwinConfigurations = {
    aether = darwinSystem {
      inherit specialArgs;
      modules = [
        ./aether
      ];
    };
  };
}
