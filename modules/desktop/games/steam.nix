{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  cfg = config.modules.desktop.games.steam;
  hardware = config.modules.profiles.hardware;
  gamemodeCfg = config.modules.desktop.games.gamemode;
  gamescopeCfg = config.modules.desktop.games.gamescope;
  protonupPackage = config.modules.desktop.games.protonup.package;
  nvidiaEnabled = any (mod: hasPrefix "gpu/nvidia" mod) hardware;
  steamPackage =
    if nvidiaEnabled
    then
      pkgs.steam.override {
        # Встраиваем переменные окружения прямо в Steam
        extraEnv = lib.mkIf nvidiaEnabled {
          __NV_PRIME_RENDER_OFFLOAD = "1";
          __NV_PRIME_RENDER_OFFLOAD_PROVIDER = "NVIDIA-G0";
          __GLX_VENDOR_LIBRARY_NAME = "nvidia";
          __VK_LAYER_NV_optimus = "NVIDIA_only";
        };
      }
    else pkgs.steam;
in {
  options.modules.desktop.games.steam = {
    enable = mkEnableOption "TODO";
    package = mkOpt' types.package steamPackage "Default package to use as steam";
  };

  config = mkIf (cfg.enable) {
    programs.steam = {
      enable = true;
      package = cfg.package;
      extraPackages =
        [
          pkgs.mangohud
          pkgs.keyutils
          pkgs.libgdiplus
        ]
        ++ (optionals (gamescopeCfg.enable) [pkgs.gamescope])
        ++ (optionals (gamemodeCfg.enable) [pkgs.gamemode]);

      extraCompatPackages = [pkgs.proton-ge-bin pkgs.steamtinkerlaunch];

      # Open ports in the firewall for Steam Local Network Game Transfers.
      localNetworkGameTransfers.openFirewall = true;

      # Open ports in the firewall for Steam Remote Play
      remotePlay.openFirewall = true;
      protontricks.enable = true;
    };

    # Managing proton versions
    environment.systemPackages = [protonupPackage];
  };
}
