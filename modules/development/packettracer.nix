{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  cfg = config.modules.development.networks.packettracer;
  pt = pkgs.ciscoPacketTracer9;
  ver = "9";
in {
  options.modules.development.networks.packettracer = with types; {
    enable = mkEnableOption "Enable Cisco packet tracer";
    withoutLogin = mkOpt' bool true "Enclose packet tracer in firejail to prevent login";
  };

  config = mkMerge [
    (mkIf (cfg.enable && !cfg.withoutLogin) {
      environment.systemPackages = [pt];
    })
    (mkIf (cfg.enable && cfg.withoutLogin) {
      programs.firejail = {
        enable = true;
        wrappedBinaries = {
          packettracer = {
            executable = getExe pt;

            # Will still want a .desktop entry as the package is not directly added
            # FIX: as for pt9 it can not work same
            desktop = "${pt}/share/applications/cisco-pt${ver}.desktop.desktop";

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
