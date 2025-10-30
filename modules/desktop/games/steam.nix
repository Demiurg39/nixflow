{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  cfg = config.modules.desktop.games.steam;
in {
  options.modules.desktop.games.steam = {
    enable = mkEnableOption "TODO";
    package = mkOpt' types.package pkgs.steam "Default package to use as steam";
  };

  config = mkIf (cfg.enable) {
    programs.steam = {
      enable = true;
      package = cfg.package;
      extraPackages = [pkgs.mangohud];
      extraCompatPackages = [pkgs.proton-ge-bin pkgs.steamtinkerlaunch];

      # Open ports in the firewall for Steam Local Network Game Transfers.
      localNetworkGameTransfers.openFirewall = true;

      # Open ports in the firewall for Steam Remote Play
      remotePlay.openFirewall = true;
      protontricks.enable = true;
    };
  };
}
