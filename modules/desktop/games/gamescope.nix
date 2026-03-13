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
        args =
          [
            "--rt"
            "--grab"
            "--force-grab-cursor"
          ]
          ++ optionals (config.modules.desktop.type == "wayland") ["--expose-wayland"];
      };
    };
  };
}
