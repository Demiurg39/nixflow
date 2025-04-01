{pkgs, ...}: {
  imports = with builtins;
    map (fn: ./${fn})
    (filter (fn: fn != "default.nix") (attrNames (readDir ./.)));

  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    systemd.enable = true;
  };

  home.packages = with pkgs; [
    brightnessctl
    blueberry
    ddcutil
    easyeffects
    grim
    gnome-control-center
    gnome-tweaks
    hyprpicker
    swww
    slurp
    tesseract
    wl-clipboard
    wf-recorder
    wlsunset
    xdg-desktop-portal
    xdg-desktop-portal-gtk
    xdg-desktop-portal-hyprland
  ];
}
