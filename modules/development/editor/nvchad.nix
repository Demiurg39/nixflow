{
  config,
  inputs,
  pkgs,
  lib,
  ...
}:
with lib; let
  cfg = config.modules.development.editor.nvchad;
in {
  options.modules.development.editor.nvchad = with types; {
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
      python3
    ];
  };
}
