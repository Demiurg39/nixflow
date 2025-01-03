{
  imports = [
    ./home-pkgs.nix
    ./modules
  ];

  home = {
    username = "demi";
    homeDirectory = "/home/demi";
    stateVersion = "24.05";
  };

  # install home-manager and manage itself
  programs.home-manager.enable = true;

}
