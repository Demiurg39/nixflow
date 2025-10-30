{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.modules.desktop.terminal.direnv;
in {
  options.modules.desktop.terminal.direnv = with types; {
    enable = mkEnableOption "Whether to enable direnv or not";
  };

  config = mkIf (cfg.enable) {
    home.programs.direnv = {
      enable = true;
      enableNushellIntegration = config.modules.desktop.terminal.shell.nushell.enable;
      nix-direnv.enable = true;
    };
  };
}
