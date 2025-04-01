{inputs, ...}: {
  imports = [
    inputs.nvchad4nix.homeManagerModule
  ];

  programs.nvchad = {
    enable = true;
    extraPackages = [];
    hm-activation = false;
    backup = false;
  };
}
