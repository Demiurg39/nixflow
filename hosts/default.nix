{
  self,
  pkgs,
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
          ./asura/secrets.nix

          "${mod}/core/lanzaboote.nix"

          "${mod}/hardware/nvidia-laptop.nix"
          # BUG: cause some problems with booting and poweroff
          # or not?
          # "${mod}/hardware/asusctl.nix"

          "${mod}/network/localsend.nix"
          "${mod}/network/packettracer.nix"

          "${mod}/programs/gamemode.nix"
          "${mod}/programs/gaming.nix"
          "${mod}/programs/hyprland"
          "${mod}/programs/adb.nix"
          "${mod}/programs/diagnostics.nix"
          "${mod}/programs/virt-manager.nix"

          "${mod}/services/kanata"
          "${mod}/services/syncthing.nix"
          inputs.agenix.nixosModules.default

          {
            environment.systemPackages = [
              inputs.agenix.packages.x86_64-linux.default
            ];
          }

          {
            home-manager = {
              users.demi.imports = homeImports."demi@asura";
              extraSpecialArgs = specialArgs;
            };
          }
        ];
    };
  };
}
