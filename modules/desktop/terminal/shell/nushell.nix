{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  cfg = config.modules.desktop.terminal.shell.nushell;
in {
  options.modules.desktop.terminal.shell.nushell = with types; {
    enable = mkEnableOption "Enable nushell";
    setDefault = mkBoolOpt false;
  };

  config = mkIf (cfg.enable) {
    environment.shells = [pkgs.nushell];
    environment.systemPackages = with pkgs; [
      bash
      carapace
      fish
      zsh
    ];

    home.programs.nushell = {
      enable = true;
      settings = {};
      shellAliases = {};
      configFile.source = "${config.flake.configDir}/nushell/config.nu";
      extraEnv = builtins.readFile "${config.flake.configDir}/nushell/env.nu";
    };

    home.programs.nix-index.enableNushellIntegration = true;
  };
}
