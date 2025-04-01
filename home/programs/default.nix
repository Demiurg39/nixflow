{pkgs, ...}: {
  imports = [
    ./browsers/librewolf.nix
    ./media
    ./office
    ./fonts.nix
    ./fuzzel.nix
    ./spotify.nix
    ./theme.nix
  ];

  home.packages = with pkgs; [
    keepassxc # password manager
    mission-center # system monitor

    # file-manager
    nemo
    nemo-fileroller
    file-roller

    # messenger
    telegram-desktop
    whatsapp-for-linux
  ];
}
