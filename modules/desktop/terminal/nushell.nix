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
      extraEnv = ''
        $env.CARAPACE_BRIDGES = 'zsh,fish,bash' # optional
        $env.XDG_CACHE_HOME = $nu.home-path + "/.cache"  # optional
      '';
    };
    home.programs.direnv = {
      enable = true;
      enableNushellIntegration = true;
      nix-direnv.enable = true;
    };

    home.programs.yazi = {
      enable = true;
      enableNushellIntegration = true;
    };

    home.packages = with pkgs; [
      mediainfo
      exiftool
    ];

    home.programs.zoxide = {
      enable = true;
      enableNushellIntegration = config.modules.desktop.terminal.shells.nushell.enable;
    };

    home.programs.atuin = {
      enable = true;
      enableNushellIntegration = config.modules.desktop.terminal.shells.nushell.enable;
    };
  };
}
