{ inputs, pkgs, ... }: let
  inherit (inputs) home-manager;
in {

  imports = [ home-manager.nixosModules.home-manager ];
  
  home-manager = {
    backupFileExtension = "old";
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit inputs pkgs; };
  };

  home-manager.users.demi = import ./../../home-manager/home.nix;

}
