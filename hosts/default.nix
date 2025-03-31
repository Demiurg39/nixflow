{
  self,
  inputs,
  ...
}: {
  flake.nixosConfigurations = let
    inherit (inputs.nixpkgs.lib) nixosSystem;

    homeImports = import "${self}/home/profiles";

    mod = "${self}/system";

    # get the basic config to build on top of
    inherit (import mod) desktop laptop;

    # get these into the module system
    specialArgs = {inherit inputs self;};
  in {
    asura = nixosSystem {
      inherit specialArgs;
      modules =
        laptop
        ++ [
          ./asura

          # "${mod}/boot/lanzaboote.nix"

          "${mod}/programs/gamemode.nix"
          "${mod}/programs/gaming.nix"
          "${mod}/programs/hyprland"
          "${mod}/programs/adb.nix"

          "${mod}/services/kanata"

          {
            home-manager = {
              users.demi.imports = homeImports."demi@asura";
              backupFileExtension = ".hm-backup";
              extraSpecialArgs = specialArgs;
            };
          }
        ];
    };
  };
}
