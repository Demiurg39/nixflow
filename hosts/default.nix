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
}
