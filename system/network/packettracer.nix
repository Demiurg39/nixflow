{
  pkgs,
  lib,
  ...
}: {
  environment.systemPackages = with pkgs; [
    gns3-gui
    gns3-server
  ];

  programs.firejail = {
    enable = true;
    wrappedBinaries = {
      packettracer8 = {
        executable = lib.getExe (pkgs.ciscoPacketTracer8.override {
          # packetTracerSource = ./CiscoPacketTracer822_amd64_signed.deb;
        });

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
}
