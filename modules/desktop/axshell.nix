{
  config,
  inputs,
  lib,
  ...
}:
with lib; let
  cfg = config.modules.desktop.hyprland.ax-shell;
in {
  options.modules.desktop.hyprland.ax-shell = {
    enable = mkEnableOption "TODO: ";
  };

  config = mkIf (cfg.enable) {
    home-manager.users.${config.user.name}.imports = [inputs.ax-shell.homeManagerModules.default];

    home.programs.ax-shell = {
      enable = true;
      settings = {
        # --- Cursor ---
        cursor = {
          package = pkgs.oreo-cursors-plus;
          name = "oreo_black_cursors";
          size = 24;
        };

        # --- Bar & Dock ---
        bar = {
          position = "Top"; # "Top", "Bottom", "Left", "Right"
          theme = "Pills"; # "Pills", "Dense", "Edge"
        };
        dock.enable = false; # Disable the dock
        panel.theme = "Notch"; # "Notch", "Panel"

        # --- Keybindings ---
        keybindings.launcher = {
          prefix = "SUPER";
          suffix = "SPACE";
        };
      };
    };
  };
}
