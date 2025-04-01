{pkgs, ...}: {
  imports = with builtins;
    map (fn: ./${fn})
    (filter (fn: fn != "default.nix") (attrNames (readDir ./.)));

  home.packages = with pkgs; [
    libnotify # Notification lib

    fd # Better find
    file # Checks filetype
    jq # JSON pretty printer and manipulator
    ripgrep # Better grep
    yad # GUI dialog

    p7zip # # 7z archives
    unzip # zip archives
    unrar-free # rar archives

    # playerctl # For controlling media
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
