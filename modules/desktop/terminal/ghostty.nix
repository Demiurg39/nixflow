{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  cfg = config.modules.desktop.terminal.ghostty;
in {
  options.modules.desktop.terminal.ghostty = {
    enable = mkEnableOption "Whether to enable ghostty";
    setDefault = mkOpt types.bool false;
  };

  config = mkIf (cfg.enable) {
    modules.desktop.terminal.default =
      if cfg.setDefault
      then "ghostty"
      else "";
    modules.desktop.terminal.spawnCmd = "ghostty +new-window";
    fonts.packages = [pkgs.nerd-fonts.iosevka-term];

    home.programs.ghostty = {
      enable = true;
      systemd.enable = true;
      settings = {
        async-backend = "auto";
        background-blur = 40;
        background-blur-radius = 25;
        background-opacity = 0.95;
        clipboard-paste-protection = true;
        copy-on-select = false;
        cursor-style = "block";
        cursor-style-blink = false;
        font-family = "Iosevka";
        quit-after-last-window-closed = true;
        quit-after-last-window-closed-delay = "5m";
        window-decoration = "none";
        window-padding-x = 5;
        window-padding-y = 3;
        window-vsync = true;
      };
    };
  };
}
