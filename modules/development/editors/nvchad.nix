{
  config,
  inputs,
  pkgs,
  lib,
  ...
}:
with lib; let
  cfg = config.modules.development.editors.nvchad;
  qmlls-wrapped = pkgs.writeShellScriptBin "qmlls" ''
    QML_LIBS="${lib.makeSearchPath "lib/qt-6/qml" [
      pkgs.kdePackages.qtdeclarative
      pkgs.quickshell
      pkgs.kdePackages.qt5compat
    ]}"

    PLUGIN_LIBS="${lib.makeSearchPath "lib/qt-6/plugins" [
      pkgs.kdePackages.qtbase
      pkgs.kdePackages.qtdeclarative
      pkgs.quickshell
    ]}"

    QUICKSHELL="${config.flake.configDir}/quickshell"

    export QML_IMPORT_PATH="$QML_LIBS:$QUICKSHELL:$PWD"
    export QT_PLUGIN_PATH="$PLUGIN_LIBS"

    exec ${pkgs.kdePackages.qtdeclarative}/bin/qmlls "$@"
  '';
in {
  options.modules.development.editors.nvchad = with types; {
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
        qmlls-wrapped
        pkgs.ripgrep
        pkgs.rustc
        pkgs.tectonic
      ];
      hm-activation = false;
      backup = false;
    };
  };
}
