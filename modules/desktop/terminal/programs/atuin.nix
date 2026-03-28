{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.modules.desktop.terminal.programs.atuin;
  nushellCfg = config.modules.desktop.terminal.shell.nushell;
in {
  options.modules.desktop.terminal.programs.atuin = with types; {
    enable = mkEnableOption "Whether to enable atuin";
  };

  config = mkIf (cfg.enable) {
    home.programs.atuin = {
      enable = true;
      enableNushellIntegration = nushellCfg.enable;
    };
  };
}
