{ inputs, ... }: let 
  inherit (inputs) nixvim;
in {
  imports = [ 
    nixvim.homeManagerModules.nixvim
  ];  

  programs.nixvim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
  };
}
