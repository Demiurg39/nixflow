{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  cfg = config.modules.development.networks.packettracer;
in {
  options.modules.development.networks.packettracer = with types; {
    enable = mkEnableOption "Enable Cisco packet tracer";

    withoutLogin = mkOption {
      type = bool;
      default = true;
      description = ''If true, packet tracer will be run in firejail to preven login'';
    };
  };

  config = mkMerge [
    (mkIf (cfg.enable && !cfg.withoutLogin) {
      environment.systemPackages = [pkgs.ciscoPacketTracer8];
    })
    (mkIf (cfg.enable && cfg.withoutLogin) {
      programs.firejail = {
        enable = true;
        wrappedBinaries = {
          packettracer8 = {
            executable = getExe pkgs.ciscoPacketTracer8;

            # Will still want a .desktop entry as the package is not directly added
            desktop = "${pkgs.ciscoPacketTracer8}/share/applications/cisco-pt8.desktop.desktop";

            extraArgs = [
              # This should make it run in isolated netns, preventing internet access
              ''--net=none''

              # firejail is only needed for network isolation so no futher profile is needed
              ''--noprofile''

              # Packet tracer doesn't play nice with dark QT themes so this
              # should unset the theme. Uncomment if you have this issue.
              ''--env=QT_STYLE_OVERRIDE=''

              ''--env=QT_QPA_PLATFORM=xcb''
              ''--env=GDK_BACKEND=x11''
            ];
          };
        };
      };
    })
  ];
}
