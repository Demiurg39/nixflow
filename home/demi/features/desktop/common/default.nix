{pkgs, ...}: {
  imports = [
    ./font.nix
    ./gtk.nix
    ./librewolf.nix
    ./qt.nix
    ./spotify.nix
    ./xdg-mime.nix
  ];

  home.packages = with pkgs; [
    clapper # media player
    ferdium
    file-roller
    gimp
    loupe # image viewer
    mission-center # system monitor
    nemo
    nemo-fileroller
    pavucontrol
    telegram-desktop
  ];

  # xdg.portal.enable = true;
}
