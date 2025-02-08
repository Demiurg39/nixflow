{...}: {
  imports = [
    ./global

    ./features/desktop/hyprland
    ./features/desktop/common
    ./features/desktop/common/wayland-wm

    ./features/games
  ];

  features = {
    cli = {
      # nushell.enable = true;
      zsh.enable = true;
    };
  };
}
