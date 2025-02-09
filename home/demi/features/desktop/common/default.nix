{pkgs, ...}: {
  imports = [
    ./font.nix
    ./librewolf.nix
    ./qt.nix
    ./spotify.nix
    ./theme.nix
    ./xdg-mime.nix
  ];

  home.packages = with pkgs; [
    clapper # media player
    ferdium
    file-roller
    gimp
    keepassxc
    loupe # image viewer
    mission-center # system monitor
    nemo
    nemo-fileroller
    pavucontrol
    telegram-desktop
  ];
}
