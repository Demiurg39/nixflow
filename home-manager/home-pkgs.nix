{ pkgs, ... }: {

  home.packages = with pkgs; [

    # Desktop apps
    clapper
    librewolf
    loupe
    lutris
    mpv
    mission-center
    neovide
    telegram-desktop
    whatsapp-for-linux

    # Cli
    brightnessctl
    cliphist
    ffmpeg
    git
    gitleaks
    fzf
    fastfetch
    htop
    lazygit
    playerctl
    ripgrep
    yazi
    unzip
    unrar
    p7zip
    wl-clipboard
    zip

    # WM
    fuzzel
    kitty
    libnotify
    swww
    xdg-desktop-portal
    xdg-desktop-portal-gtk
    xdg-desktop-portal-hyprland

    # Nerdfonts
    nerd-fonts.fantasque-sans-mono
    nerd-fonts.fira-code
    nerd-fonts.jetbrains-mono
    nerd-fonts.mononoki
    nerd-fonts.space-mono
    nerd-fonts.ubuntu
    nerd-fonts.ubuntu-mono

    # Fonts
    cascadia-code
    dejavu_fonts
    font-awesome
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
    powerline-fonts
    powerline-symbols
  ];

}
