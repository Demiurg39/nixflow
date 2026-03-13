{
  config,
  inputs,
  lib,
  ...
}:
with lib; let
  cfg = config.modules.desktop.hyprland.ax-shell;
  monitors = config.modules.desktop.hyprland.monitors;

  primaryMonitor = findFirst (m: m.primary) null monitors;
  fallbackMonitor =
    if monitors != []
    then head monitors
    else null;
  targetMonitor =
    if primaryMonitor != null
    then primaryMonitor
    else fallbackMonitor;
  res =
    if targetMonitor != null
    then toString targetMonitor.refresh_rate
    else "60";

  wallpaperTransition = ["img" "-t" "grow" "--transition-duration" "1.2" "--transition-pos" "center" "--transition-fps" res "-f" "Lanczos3"];
  # wallpaperTransition = ["img" "-t" "fade" "--transition-duration" "1.2" "--transition-step" "255" "--transition-fps" res "-f" "Lanczos3"];
  # wallpaperTransition = ["img" "-t" "wipe" "--transition-duration" "0.5" "--transition-angle" "45" "--transition-fps" res "-f" "Lanczos3"];
  # wallpaperTransition = ["img" "-t" "wave" "--transition-duration" "1.5" "--transition-angle" "0" "--transition-fps" res "-f" "Lanczos3"];
  # wallpaperTransition = ["img" "-t" "wipe" "--transition-duration" "0.8" "--transition-angle" "90" "--transition-fps" res "-f" "Lanczos3"];
  # wallpaperTransition = ["img" "-t" "outer" "--transition-duration" "2.0" "--transition-step" "100" "--transition-fps" res "-f" "Lanczos3"];
in {
  options.modules.desktop.hyprland.ax-shell = {
    enable = mkEnableOption "TODO: ";
  };

  config = mkIf (cfg.enable) {
    nixpkgs.overlays = [inputs.ax-shell.overlays.default];
    home.modules = [inputs.ax-shell.homeManagerModules.default];

    home.programs.ax-shell = {
      enable = true;
      settings = {
        # --- Cursor ---
        # cursor = {
        #   package = pkgs.oreo-cursors-plus;
        #   name = "oreo_black_cursors";
        #   size = 24;
        # };

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
