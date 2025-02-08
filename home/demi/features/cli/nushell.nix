{
  config,
  options,
  lib,
  ...
}: let
  cfg = config.features.cli.nushell;
in {
  options.features.cli.nushell = {
    enable = lib.mkEnableOption "enable Nushell with configuration";
  };

  config = lib.mkIf cfg.enable {
    programs.nushell = {
      enable = true;
    };
  };
}
