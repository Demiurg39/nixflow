{pkgs, ...}: {
  imports = with builtins;
    map (fn: ./${fn})
    (filter (fn: fn != "default.nix") (attrNames (readDir ./.)));

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
