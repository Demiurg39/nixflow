{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  cfg = config.modules.desktop.games.lutris;
  hardware = config.modules.profiles.hardware;
  steamCfg = config.modules.desktop.games.steam;
  protonupPackage = config.modules.desktop.games.protonup.package;
  nvidiaEnabled = any (mod: hasPrefix "gpu/nvidia" mod) hardware;
  lutrisPackage =
    if nvidiaEnabled
    then
      pkgs.lutris.override {
        extraEnv = lib.mkIf nvidiaEnabled {
          __NV_PRIME_RENDER_OFFLOAD = "1";
          __NV_PRIME_RENDER_OFFLOAD_PROVIDER = "NVIDIA-G0";
          __GLX_VENDOR_LIBRARY_NAME = "nvidia";
          __VK_LAYER_NV_optimus = "NVIDIA_only";
        };
      }
    else pkgs.lutris;
in {
  options.modules.desktop.games.lutris = {
    enable = mkEnableOption "TODO";
    package = mkOpt' (types.package) lutrisPackage "TODO";
    protonPackages = mkOpt' (types.listOf types.package) [pkgs.proton-ge-bin] "TODO";
    winePackages = mkOpt' (types.listOf types.package) [pkgs.wineWow64Packages.staging] "TODO";
  };

  config = mkIf (cfg.enable) {
    home.programs.lutris = {
      enable = true;
      extraPackages = [pkgs.mangohud];
      steamPackage =
        if (steamCfg.enable)
        then steamCfg.package
        else pkgs.steam;
      protonPackages = cfg.protonPackages;
      winePackages = cfg.winePackages;
    };

    environment.systemPackages = [protonupPackage];
  };
}
