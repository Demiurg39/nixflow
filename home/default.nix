{inputs, ...}: {
  imports = [
    inputs.nix-index-database.hmModules.nix-index
  ];

  programs.nix-index.enable = true;
  programs.nix-index-database.comma.enable = true;
  programs.home-manager.enable = true;

  home = {
    username = "demi";
    homeDirectory = "/home/demi";
    stateVersion = "24.05";
  };
}
