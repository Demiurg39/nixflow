{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.modules.system.adb;
in {
  options.modules.system.adb = {
    enable = mkEnableOption "TODO";
  };
  config = mkIf (cfg.enable) {
    programs.adb.enable = true;
    user.extraGroups = ["adbusers"];
  };
}
