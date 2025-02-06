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
    loupe # image viewer
    mission-center # system monitor
    pavucontrol
    telegram-desktop
  ];

  # xdg.portal.enable = true;
}
