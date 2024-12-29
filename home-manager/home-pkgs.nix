{ pkgs, ... }: {

  home.packages = with pkgs; [

    # Desktop apps
    librewolf
    mpv
    neovide
    spotify
    telegram-desktop
    whatsapp-for-linux
    lutris

    # Cli
    brightnessctl
    cliphist
    ffmpeg
    git
    fzf
    fastfetch
    htop
    lazygit
    neovim
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
    nerd-fonts.jetbrains-mono
    nerd-fonts.fira-code
    nerd-fonts.ubuntu
    nerd-fonts.ubuntu-mono
    nerd-fonts.space-mono
    nerd-fonts.mononoki
    nerd-fonts.fantasque-sans-mono

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
