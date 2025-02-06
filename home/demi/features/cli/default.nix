{pkgs, ...}: {
  imports = [
    ./atuin.nix
    ./bat.nix
    ./direnv.nix
    ./eza.nix
    ./fastfetch
    ./fzf.nix
    ./git.nix
    ./lazygit.nix
    ./nivix.nix
    ./nushell.nix
    ./starship.nix
    ./yazi.nix
    ./zoxide.nix
    ./zsh.nix
  ];

  home.packages = with pkgs; [
    bc # Calculator
    coreutils # base utils
    fd # Better find
    gitleaks # git secrets scaner
    htop # system monitor
    jq # JSON pretty printer and manipulator
    mlocate
    p7zip
    playerctl
    ripgrep # Better grep
    rainfrog
    unzip
    unrar-free
    zip

    # nvd # Differ
    # nix-diff # Differ, more detailed
    # nix-output-monitor
    # nh # Nice wrapper for NixOS and HM

    # comma # Install and run programs by sticking a , before them
    # distrobox # Nice escape hatch, integrates docker images with my environment

    # bottom # System viewer
    # ncdu # TUI disk usage
    # httpie # Better curl
    # diffsitter # Better diff
    # trekscii # Cute startrek cli printer
    # timer # To help with my ADHD paralysis
  ];
}
