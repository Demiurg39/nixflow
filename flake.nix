{
  description = "My system configuration flake";

  inputs = {
    systems.url = "github:nix-systems/default-linux";

    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    flake-parts.url = "github:hercules-ci/flake-parts";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    hyprland.url = "github:hyprwm/Hyprland";
    hyprland.inputs.nixpkgs.follows = "nixpkgs";

    nivix.url = "github:demiurg39/nivix";
    nivix.inputs.nixpkgs.follows = "nixpkgs";

    spicetify-nix.url = "github:Gerg-L/spicetify-nix";
    spicetify-nix.inputs.nixpkgs.follows = "nixpkgs";

    ags.url = "github:Aylur/ags/v1";
    ags.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {flake-parts, ...} @ inputs:
    flake-parts.mkFlake {inherit inputs;} {
      systems = ["x86_64-linux"];

      imports = [
        # TODO:
        # ./hosts
        # ./pre-commit-hooks.nix
      ];

      perSystem = {
        config,
        pkgs,
        ...
      }: {
        devShells.default = pkgs.mkShell {
          packages = with pkgs; [
            alejandra
            git
          ];
          name = "flake-dots";
          DIRENV_LOG_FORMAT = "";
          shellHook = ''
            ${config.pre-commit.installationScript}
          '';
        };

        formatter = pkgs.alejandra;
      };

      # nixosConfigurations = {
      #   # asus laptop
      #   asura = lib.nixosSystem {
      #     specialArgs = {
      #       inherit inputs;
      #       inherit outputs;
      #       inherit username;
      #       inherit hostname;
      #     };
      #     modules = [./hosts/asura];
      #   };
      # };

      # homeConfigurations = {
      #   demi = lib.homeManagerConfiguration {
      #     pkgs = pkgsFor.x86_64-linux;
      #     extraSpecialArgs = {inherit inputs outputs;};
      #     modules = [./home/demi/asura.nix];
      #   };
      # };
    };
}
