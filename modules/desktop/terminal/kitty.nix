{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.modules.desktop.terminal.kitty;
in {
  options.modules.desktop.terminal.kitty = with types; {
    enable = mkEnableOption "Enable kitty terminal";
  };

  config = mkIf (cfg.enable) {
    home.programs.kitty = {
      enable = true;
      keybindings = {};
      settings = {
        font_family = "FiraCode Nerd Font";
        font_size = 14;
      };
    };
  };
}
