{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  cfg = config.desktop.gnome;
in {
  options.desktop.gnome = with types; {
    enable = mkEnableOption "Enable gnome de as primary";
  };

  config = mkIf (cfg.enable) {
    environment.systemPackages = with pkgs; [
      papirus-icon-theme
      bibata-cursors
    ];

    services.displayManager.gdm.enable = true;
    services.desktopManager.gnome.enable = true;

    programs.dconf.enable = true;

    services.flatpak.enable = true;
  };
}
