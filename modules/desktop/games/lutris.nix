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
    protonPackages = mkOption {};
    winePackages = mkOption {};
  };

  config = mkIf (cfg.enable) {
    home.programs.lutris = {
      enable = true;
      extraPackages = [pkgs.mangohud];
      steamPackage =
        if (steamCfg.enable)
        then osConfig.programs.steam.package
        else pkgs.steam;
      # TODO: insert here cfg.protonPackages ? [pkgs.proton-ge-bin]
      protonPackages = [pkgs.proton-ge-bin];
      # TODO: winePackages = cfg.winePackages ? [pkgs.wineWow64Packages.full];
      winePackages = [pkgs.wineWow64Packages.full];
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
