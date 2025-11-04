{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.modules.desktop.office.onlyoffice;
in {
  options.modules.desktop.office.onlyoffice = {
    enable = mkEnableOption "TODO";
  };

  config = mkIf (cfg.enable) {
    home.programs.onlyoffice = {
      enable = true;
      settings = {
        UITheme = "theme-contrast-dark";
        editorWindowMode = false;
        maximized = true;
      };
    };
  };
}
