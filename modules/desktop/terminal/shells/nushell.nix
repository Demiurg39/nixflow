{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  cfg = config.modules.desktop.terminal.shells.nushell;
in {
  options.modules.desktop.terminal.shells.nushell = with types; {
    enable = mkEnableOption "Enable nushell";
  };

  config = mkIf (cfg.enable) {
    environment.systemPackages = with pkgs; [
      bash
      carapace
      fish
      zsh
    ];
    home.programs.nushell = {
      enable = true;
      configFile.source = "${config.flake.configDir}/nushell/config.nu";
      extraEnv = builtins.readFile "${config.flake.configDir}/nushell/env.nu";
    };

    environment.shells = [pkgs.nushell];
  };
}
