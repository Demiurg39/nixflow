{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  hardware = config.modules.profiles.hardware;
  cfg = config.modules.desktop.programs.obs-studio;
  nvidiaEnabled = any (mod: hasPrefix "gpu/nvidia" mod) hardware;
  obsPackage =
    if nvidiaEnabled
    then
      pkgs.symlinkJoin {
        name = "obs-studio-nvidia";
        paths = [pkgs.obs-studio];
        buildInputs = [pkgs.makeWrapper];
        postBuild = ''
          wrapProgram $out/bin/obs \
            --set __NV_PRIME_RENDER_OFFLOAD 1 \
            --set __NV_PRIME_RENDER_OFFLOAD_PROVIDER NVIDIA-G0 \
            --set __GLX_VENDOR_LIBRARY_NAME nvidia \
            --set __VK_LAYER_NV_optimus NVIDIA_only \
            --prefix LD_LIBRARY_PATH : /run/opengl-driver/lib:/run/opengl-driver-32/lib
        '';
      }
    else pkgs.obs-studio;
in {
  options.modules.desktop.programs.obs-studio = {
    enable = mkEnableOption "TODO";
  };

  config = mkIf (cfg.enable) {
    programs.obs-studio = {
      enable = true;
      package = obsPackage;
      plugins = with pkgs.obs-studio-plugins; [
        obs-pipewire-audio-capture
      ];
    };
  };
}
