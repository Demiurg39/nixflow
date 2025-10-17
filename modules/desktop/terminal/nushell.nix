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
  };

  config = mkIf (cfg.enable) {
    environment.systemPackages = with pkgs; [
      atuin
      bash
      carapace
      fish
      zsh
      zoxide
    ];
    programs.yazi.enable = true;
    programs.direnv.enable = true;
    programs.direnv.nix-direnv.enable = true;
  };
}
