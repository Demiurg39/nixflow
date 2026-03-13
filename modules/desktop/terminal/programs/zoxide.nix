{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.modules.desktop.terminal.programs.zoxide;
  nushellCfg = config.modules.desktop.terminal.shells.nushell;
in {
  options.modules.desktop.terminal.programs.zoxide = with types; {
    enable = mkEnableOption "Whether to enable zoxide";
  };

  config = mkIf (cfg.enable) {
    home.programs.zoxide = {
      enable = true;
      enableNushellIntegration = nushellCfg.enable;
    };
  };
}
