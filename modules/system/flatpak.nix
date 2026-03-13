{
  inputs,
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.modules.system.flatpak;
in {
  imports = [inputs.nix-flatpak.nixosModules.nix-flatpak];

  options.modules.system.flatpak = {
    enable = mkEnableOption "Enable nix-flatpack";
  };

  config = mkIf (cfg.enable) {
    services.flatpak.enable = true;
    services.flatpak.uninstallUnmanaged = true;

    services.flatpak.update.auto = {
      enable = true;
      onCalendar = "weekly";
    };
  };
}
