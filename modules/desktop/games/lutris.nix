{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  cfg = config.modules.desktop.games.lutris;
  steamCfg = config.modules.desktop.games.steam;
in {
  options.modules.desktop.games.lutris = {
    enable = mkEnableOption "TODO";
    protonPackages = mkOpt' (types.listOf packages) [] "TODO";
    winePackages = mkOpt' (types.listOf packages) [] "TODO";
  };

  config = mkIf (cfg.enable) {
    home.programs.lutris = {
      enable = true;
      extraPackages = [pkgs.mangohud];
      steamPackage =
        if (steamCfg.enable)
        then osConfig.programs.steam.package
        else pkgs.steam;
      protonPackages = [(cfg.protonPackages ? pkgs.proton-ge-bin)];
      winePackages = [(winePackages ? pkgs.wineWow64Packages.full)];
    };

    home.packages = [pkgs.protonup-qt];
    #   (lutris.override {
    #     extraLibraries = pkgs: [
    #       protobuf
    #       libvdpau
    #       glxinfo
    #     ];
    #   })
  };
}
