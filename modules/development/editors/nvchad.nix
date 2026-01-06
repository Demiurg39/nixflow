{
  config,
  inputs,
  pkgs,
  lib,
  ...
}:
with lib; let
  cfg = config.modules.development.editors.nvchad;
in {
  options.modules.development.editors.nvchad = with types; {
    enable = mkEnableOption "Enable nushell";
  };

  config = mkIf (cfg.enable) {
    home-manager.users.${config.user.name}.imports = [inputs.nix4nvchad.homeManagerModule];

    home.packages = let
      qmlls-wrapped = pkgs.writeShellScriptBin "qmlls" ''
        # 1. Формируем пути к библиотекам Nix
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

        # 2. Экспортируем.
        # Добавляем :$PWD в конец, чтобы видеть локальные модули в папке проекта
        export QML_IMPORT_PATH="$QML_LIBS:$QUICKSHELL:$PWD"
        export QT_PLUGIN_PATH="$PLUGIN_LIBS"

        # 3. Запускаем оригинал
        exec ${pkgs.kdePackages.qtdeclarative}/bin/qmlls "$@"
      '';
    in [
      pkgs.cargo
      pkgs.rustc
      pkgs.gdb
      pkgs.mermaid-cli
      pkgs.python3
      qmlls-wrapped
      pkgs.openjdk21
      pkgs.neovide
    ];

    home.programs.nvchad = {
      enable = true;
      extraPackages = [
        pkgs.alejandra
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
