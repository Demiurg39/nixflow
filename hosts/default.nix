{
  inputs,
  self,
  lib,
  ...
}: let
  mkHost = name: system:
    lib.nixosSystem {
      modules =
        [
          {
            networking.hostName = lib.mkDefault name;
            nixpkgs.hostPlatform = lib.mkDefault system;
            environment.systemPackages = [
              inputs.agenix.packages.${system}.default
            ];
          }
          ./${name}

          inputs.agenix.nixosModules.default
          inputs.home-manager.nixosModules.home-manager
        ]
        ++ builtins.attrValues self.nixosModules;

      # This allows to easily access flake inputs and outputs
      # from nixos modules, so it's a little bit cleaner
      # TODO: make my theme module
      specialArgs = {inherit inputs self lib;};
    };
in {
  asura = mkHost "asura" "x86_64-linux";
}
