{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.modules.desktop.terminal.zoxide;
in {
  options.modules.desktop.terminal.zoxide = with types; {
    enable = mkEnableOption "Whether to enable zoxide";
  };

  config = mkIf (cfg.enable) {
    home.programs.zoxide = {
      enable = true;
      enableNushellIntegration = config.modules.desktop.terminal.shell.nushell.enable;
    };
  };
}
