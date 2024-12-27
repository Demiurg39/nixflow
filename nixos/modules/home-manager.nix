{ inputs, pkgs, ... }: {

  imports = [ inputs.home-manager.nixosModules.home-manager ];

  environment.systemPackages = [ pkgs.home-manager ];
  
  home-manager = {
    backupFileExtension = "old";
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit inputs pkgs; };
    users = {
      demi = import ./../../home-manager/home.nix; 
    };
  };

}
