{
  config,
  inputs,
  pkgs,
  lib,
  ...
}:
with lib; let
  cfg = config.desktop.editor.nvchad;
in {
  options.desktop.editor.nvchad = with types; {
    enable = mkEnableOption "Enable nushell";
  };

  config = mkIf (cfg.enable) {
    environment.systemPackages = with pkgs; [
      inputs.nix4nvchad.packages.${system}.default
      alejandra
      unzip
      nodejs
      nixd
      cargo
      clang-tools
      gcc
      gdb
      ghostscript
      fd
      lazygit
      openjdk21
      ripgrep
      rustc
      tectonic
      python39
    ];
  };
}
