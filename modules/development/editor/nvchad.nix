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
    home.modules = [inputs.nix4nvchad.homeManagerModule];

    home.packages = [
      pkgs.cargo
      pkgs.rustc
      pkgs.gdb
      pkgs.mermaid-cli
      pkgs.python3
      pkgs.openjdk21
      pkgs.neovide
    ];

    home.programs.nvchad = {
      enable = true;
      extraPackages = [
        pkgs.alejandra
        pkgs.asm-lsp
        pkgs.asmfmt
        pkgs.nixd
        pkgs.nodejs
        pkgs.clang-tools
        pkgs.ghostscript
        pkgs.fd
        pkgs.lazygit
        pkgs.ripgrep
        pkgs.rustc
        pkgs.tectonic
      ];
      hm-activation = false;
      backup = false;
    };
  };
}
