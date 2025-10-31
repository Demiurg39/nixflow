{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  cfg = config.modules.desktop.programs.obs-studio;
in {
  options.modules.desktop.programs.obs-studio = {
    enable = mkEnableOption "TODO";
  };

  config = mkIf (cfg.enable) {
    programs.obs-studio = {
      enable = true;

      plugins =
        with pkgs.obs-studio-plugins; [
          obs-pipewire-audio-capture
        ]
        # ++ (optionals (config.modules.desktop.wayland) ["wlrobs"])
        ;
    };
  };
}
