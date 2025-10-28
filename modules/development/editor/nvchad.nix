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
    home.extraConfig = {imports = [inputs.nix4nvchad.homeManagerModule];};

    home.programs.nvchad = {
      enable = true;
      extraPackages = with pkgs; [
        alejandra
        nixd
        nodejs
        cargo
        clang-tools
        gcc
        gdb
        ghostscript
        fd
        openjdk21
        ripgrep
        rustc
        python3
        tectonic
        unzip
        lazygit
      ];
      hm-activation = false;
      backup = false;
    };

    home.packages = with pkgs; [
      neovide
    ];
  };
}
