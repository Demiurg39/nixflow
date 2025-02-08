{pkgs, ...}: {
  home.packages = with pkgs; [
    wineWowPackages.stable
    protonup-qt
    steamtinkerlaunch

    (lutris.override {
      extraLibraries = pkgs: [
        protobuf
        libvdpau
        glxinfo
      ];
      extraPkgs = pkgs: [
        gamescope
        mangohud
      ];
    })
  ];
}
