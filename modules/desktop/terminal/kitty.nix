{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  cfg = config.desktop.terminal.kitty;
in {
  options.desktop.terminal.kitty = with types; {
    enable = mkEnableOption "Enable kitty terminal";
  };

  config = mkIf (cfg.enable) {
    environment.systemPackages = [pkgs.kitty];
  };
}
