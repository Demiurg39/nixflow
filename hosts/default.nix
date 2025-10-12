{
  nixpkgs,
  self,
  ...
}: let
  inherit (self) inputs;
  mkHost = name: system:
    nixpkgs.lib.nixosSystem {
      modules =
        [
          {
            networking.hostName = nixpkgs.lib.mkDefault name;
            nixpkgs.hostPlatform = nixpkgs.lib.mkDefault system;
            nixpkgs.config.allowUnfree = true;
            nix.settings.experimental-features = ["nix-command" "flakes"];
            environment.systemPackages = [
              inputs.agenix.packages.${system}.default
            ];
          }
          ./${name}

          inputs.agenix.nixosModules.default
        ]
        ++ builtins.attrValues self.nixosModules;

      # This allows to easily access flake inputs and outputs
      # from nixos modules, so it's a little bit cleaner
      specialArgs = {
        inherit inputs;
        # TODO: make my theme module
        # theme = (import ../user).theme nixpkgs.legacyPackages.${system};
        flake = self;
      };
    };
in {
  asura = mkHost "asura" "x86_64-linux";
  #   homeImports = import "${self}/home/profiles";
  #
  #   mod = "${self}/system";
  #
  #   desktop = [
  #     ./core
  #     ./core/boot.nix
  #
  #     ./hardware/fwupd.nix
  #     ./hardware/graphics.nix
  #
  #     ./network
  #
  #     ./programs
  #
  #     ./services/greetd.nix
  #     ./services/pipewire.nix
  #   ];
  #
  #   laptop =
  #     desktop
  #     ++ [
  #       ./hardware/bluetooth.nix
  #     ];
  #
  #   # get the basic config to build on top of
  #   inherit (import mod) laptop;
  #
  # in {
  #   asura = nixosSystem {
  #     inherit specialArgs;
  #     modules =
  #       laptop
  #       ++ [
  #         "${mod}/core/lanzaboote.nix"
  #
  #         "${mod}/hardware/nvidia-laptop.nix"
  #
  #         "${mod}/network/localsend.nix"
  #         "${mod}/network/packettracer.nix"
  #
  #         "${mod}/programs/gamemode.nix"
  #         "${mod}/programs/gaming.nix"
  #         "${mod}/programs/hyprland"
  #         "${mod}/programs/adb.nix"
  #         "${mod}/programs/diagnostics.nix"
  #         "${mod}/programs/arion.nix"
  #
  #         "${mod}/services/kanata"
  #         "${mod}/services/syncthing.nix"
  #         "${mod}/services/postgresql.nix"
  #         {
  #           home-manager = {
  #             users.demi.imports = homeImports."demi@asura";
  #             extraSpecialArgs = specialArgs;
  #           };
  #         }
}
