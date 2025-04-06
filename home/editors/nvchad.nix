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
      cargo
      clang-tools
      gcc
      gdb
      ghostscript
      fd
      openjdk
      ripgrep
      rustc
      tectonic
    ];
    hm-activation = false;
    backup = false;
  };
}
