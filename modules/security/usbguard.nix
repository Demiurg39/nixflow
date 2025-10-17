{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  cfg = config.modules.security.usbguard;
in {
  options.modules.security.usbguard = with types; {
    enable = mkEnableOption "Whether to enable usbguard";

    rules = mkOption {
      type = listOf str;
      default = [];
      description = "Rules which will be added to final rules file";
      example = ["allow id 1d6b:0002 serial \"0000:00:14.0\""];
    };

    qtGui = mkOption {
      type = bool;
      default = true;
      description = "If disable then will use pkgs.usbguard-nox";
    };
  };

  config = mkIf cfg.enable {
    services.usbguard = {
      enable = true;
      rules = concatStringsSep "\n" cfg.rules;
      presentControllerPolicy = "allow";
      package =
        if cfg.qtGui
        then pkgs.usbguard
        else pkgs.usbguard-nox;
    };
  };
}
