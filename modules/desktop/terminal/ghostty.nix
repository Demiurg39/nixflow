{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  cfg = config.modules.desktop.terminal.ghostty;
  termCfg = config.modules.desktop.terminal;
  name = "ghostty";
in {
  options.modules.desktop.terminal.ghostty = {
    enable = mkEnableOption "Whether to enable ghostty";
    setDefault = mkBoolOpt false;
  };

  config = mkIf (cfg.enable) {
    modules.desktop.terminal.default =
      if cfg.setDefault
      then name
      else "";
    modules.desktop.terminal.spawnCmd =
      if termCfg.default == name
      then "ghostty"
      else "";
    fonts.packages = [pkgs.nerd-fonts.jetbrains-mono];

    home.programs.ghostty = {
      enable = true;
      systemd.enable = false;
      settings = {
        font-family = "JetBrainsMono Nerd Font";
        adjust-font-baseline = 1;
        adjust-cell-height = "15%";
        minimum-contrast = 1.3;
        font-size = 14;
        async-backend = "auto";
        background-blur = true;
        background-opacity = 0.98;
        clipboard-paste-protection = true;
        copy-on-select = false;
        cursor-style = "block";
        cursor-style-blink = true;
        theme = "Black Metal";
        quit-after-last-window-closed = true;
        quit-after-last-window-closed-delay = "5m";
        window-decoration = false;
        window-padding-x = 12;
        window-padding-y = 10;
        window-padding-balance = true;
        window-vsync = true;
      };
    };
  };
}
