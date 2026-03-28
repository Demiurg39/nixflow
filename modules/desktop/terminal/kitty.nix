{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  cfg = termCfg.kitty;
  termCfg = config.modules.desktop.terminal;
  name = "kitty";
in {
  options.modules.desktop.terminal.kitty = with types; {
    enable = mkEnableOption "Enable kitty terminal";
    setDefault = mkOpt types.bool false;
  };

  config = mkIf (cfg.enable) {
    modules.desktop.terminal.default =
      if cfg.setDefault
      then name
      else "";
    modules.desktop.terminal.spawnCmd =
      if termCfg.default == name
      then "kitty"
      else "";
    fonts.packages = [pkgs.nerd-fonts.jetbrains-mono];

    home.programs.kitty = {
      enable = true;
      keybindings = {};
      settings = {
        font_family = "JetBrainsMono Nerd Font";
        font_size = 14;
        window_padding_width = 5;
        confirm_os_window_close = 0;
        hide_window_decorations = true;
        repaint_delay = 10;
        input_delay = 3;
        sync_to_monitor = true;
        wayland_titlebar_color = "system";
        cursor_shape = "block";
        shell_integration = true;
        background_opacity = 0.98;
        background_blur = 64;
      };
    };
  };
}
