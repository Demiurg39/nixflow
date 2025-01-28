{ pkgs, ... }: {

  imports = [
    ./ferdium.nix
    ./font.nix
    ./gtk.nix
    ./librewolf.nix
    ./pavucontrol.nix
    ./playerctl.nix
    ./qt.nix
    ./spotify.nix
    ./xdg-mime.nix
  ];

  home.packages = with pkgs; [
    clapper # media player
    loupe # image viewer
    mission-center # system monitor
    telegram-desktop
  ];

  # xdg.portal.enable = true;
}
