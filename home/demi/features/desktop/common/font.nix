{ pkgs, ... }: {

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
