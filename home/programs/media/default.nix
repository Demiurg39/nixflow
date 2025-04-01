{pkgs, ...}: {
  imports = [];

  home.packages = with pkgs; [
    # audio control
    pavucontrol

    # images
    loupe
    gimp

    # videos
    celluloid
  ];
}
