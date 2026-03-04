{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  cfg = config.modules.desktop.media.blender;
  hardware = config.modules.profiles.hardware;
  nvidiaEnabled = any (mod: hasPrefix "gpu/nvidia" mod) hardware;
  blenderPkg =
    if nvidiaEnabled
    then (pkgs.blender.override {cudaSupport = true;})
    else pkgs.blender;
in {
  options.modules.desktop.media.blender = {
    enable = mkEnableOption "Enable blender";
    useFlatpak = mkOpt types.bool true;
  };

  config = mkIf cfg.enable {
    environment.systemPackages =
      if !cfg.useFlatpak
      then [blenderPkg]
      else [];
    services.flatpak.packages =
      if cfg.useFlatpak
      then ["org.blender.Blender"]
      else [];
  };
}
