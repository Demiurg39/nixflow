{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  hardware = config.modules.profiles.hardware;
in
  mkIf (any (mod: hasPrefix "audio" mod) hardware) {
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      wireplumber.enable = true;
    };

    environment.systemPackages = [pkgs.pavucontrol];

    user.extraGroups = ["audio"];

    # make pipewire realtime-capable
    security.rtkit.enable = true;
  }
