{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    inputs.nvchad4nix.homeManagerModule
  ];

  programs.nvchad = {
    enable = true;
    extraPackages = with pkgs; [
      alejandra
      nixd
      cargo
      clang-tools
      gcc
      gdb
      ghostscript
      fd
      openjdk21
      ripgrep
      rustc
      tectonic
      python39
    ];
    hm-activation = false;
    backup = false;
  };

  home.packages = with pkgs; [
    neovide
  ];
}
