{pkgs, ...}: {
  home.packages = with pkgs; [
    # Nerdfonts
    nerd-fonts.fantasque-sans-mono
    nerd-fonts.fira-code
    nerd-fonts.jetbrains-mono
    nerd-fonts.mononoki
    nerd-fonts.space-mono
    nerd-fonts.ubuntu
    nerd-fonts.ubuntu-mono

    # Fonts
    (pkgs.google-fonts.override {
      fonts = [
        "Gabarito"
        "Lexend"
        "Chakra Petch"
        "Crimson Text"
        "Alfa Slab One"
      ];
    })
    cascadia-code
    dejavu_fonts
    font-awesome
    material-symbols
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
    powerline-fonts
    powerline-symbols
  ];
}
