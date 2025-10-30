{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.modules.desktop.games.gamescope;
in {
  options.modules.desktop.games.gamescope = {
    enable = mkEnableOption "TODO";
    wayland.enable = mkEnableOption "TODO";
  };

  config = mkIf (cfg.enable) {
    programs = {
      gamescope = {
        enable = true;
        # TODO: check if this still true
        # NOTE produces error:
        # failed to inherit capabilities: Operation not permitted
        # check https://discourse.nixos.org/t/unable-to-activate-gamescope-capsysnice-option/37843
        capSysNice = true;
        args = [
          "--rt"
          # TODO: make option like wayland.enable and insert in that list
          # "--expose-wayland"
          "--grab"
          "--force-grab-cursor"
        ];
      };
    };
  };
}
