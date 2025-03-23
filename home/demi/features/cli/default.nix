{pkgs, ...}: {
  imports = with builtins;
    map (fn: ./${fn})
    (filter (fn: fn != "default.nix") (attrNames (readDir ./.)));

  home.packages = with pkgs; [
    bc # Calculator
    coreutils # base utils
    comma # Install and run programs by sticking a , before them
    fd # Better find
    glib
    htop # System monitor
    jq # JSON pretty printer and manipulator
    libnotify # Notification lib
    mlocate
    p7zip
    playerctl # For controlling media
    ripgrep # Better grep
    unzip
    unrar-free
    ydotool
    yad
    zip

    # nvd # Differ
    # nix-diff # Differ, more detailed
    # nix-output-monitor # While building provide nice ui

    # rainfrog # Lazygit like util for db control
    # distrobox # Nice escape hatch, integrates docker images with my environment

    # bottom # System viewer
    # ncdu # TUI disk usage
    # httpie # Better curl
    # diffsitter # Better diff
    # trekscii # Cute startrek cli printer
    # timer # To help with my ADHD paralysis
  ];
}
