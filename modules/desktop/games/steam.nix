{
  inputs,
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

  steamPackage = cfg.package.override {
    extraEnv =
      {
        HOME = config.home.fakeDir;
        SDL_VIDEODRIVER = "x11";
        XMODIFIERS = "@im=none";
        STEAM_RUNTIME_USE_HOST_VULKAN_ICDS = "1";
      }
      // optionalAttrs nvidiaEnabled {
        __NV_PRIME_RENDER_OFFLOAD = "1";
        __NV_PRIME_RENDER_OFFLOAD_PROVIDER = "NVIDIA-G0";
      };
  };
in {
  options.modules.desktop.games.steam = {
    enable = mkEnableOption "Whether to enable steam";
    package = mkOpt' types.package pkgs.millennium-steam "The steam package to use";
    mangohud.enable = mkEnableOption "Whether to enable mangohud";
  };

  config = mkIf (cfg.enable) {
    nixpkgs.overlays = [inputs.millennium.overlays.default];
    fonts.fontDir.enable = true;

    programs.steam = {
      enable = true;
      package = steamPackage;
      extraPackages =
        [
          pkgs.keyutils
          pkgs.libgdiplus
          pkgs.vulkan-loader
          pkgs.vulkan-tools
          pkgs.vulkan-validation-layers
          pkgs.libXtst
        ]
        ++ (optionals (gamescopeCfg.enable) [pkgs.gamescope])
        ++ (optionals (gamemodeCfg.enable) [pkgs.gamemode])
        ++ (optionals (cfg.mangohud.enable) [pkgs.mangohud]);

      extraCompatPackages = [pkgs.proton-ge-bin pkgs.steamtinkerlaunch];

      # Open ports in the firewall for Steam Remote Play
      remotePlay.openFirewall = true;
      protontricks.enable = true;
    };

    # Managing proton versions
    environment.systemPackages = [protonupPackage];
  };
}
