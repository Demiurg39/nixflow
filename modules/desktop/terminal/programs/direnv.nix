{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.modules.desktop.terminal.programs.direnv;
  nushellCfg = config.modules.desktop.terminal.shell.nushell;
in {
  options.modules.desktop.terminal.programs.direnv = with types; {
    enable = mkEnableOption "Whether to enable direnv";
  };

  config = mkIf (cfg.enable) {
    home.programs.direnv = {
      enable = true;
      enableNushellIntegration = nushellCfg.enable;
      nix-direnv.enable = true;
    };
  };
}
