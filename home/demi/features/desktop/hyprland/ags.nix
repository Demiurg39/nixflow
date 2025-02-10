{
  inputs,
  pkgs,
  ...
}: let
  ags = inputs.ags.packages.${pkgs.system}.default.override {
    extraPackages = with pkgs; [
      gtksourceview
      gtksourceview4
      webkitgtk
      webp-pixbuf-loader
      ydotool
    ];
  };
  selfPkgs = import ../../../../../pkgs/illogical-impulse.nix {
    inherit pkgs ags;
  };
in {
  # Expose the AGS launcher and AGS itself,
  # we need the launcher to launch the bar,
  # and AGS itself to toggle window.
  home.packages =
    (with selfPkgs; [
      illogical-impulse-ags-launcher
    ])
    ++ [
      ags
    ]
    ++ (with pkgs; [
      # The wallpaper switcher will be called by Hyprland,
      # so we need to expose it.
      gradience
    ]);

  # AGS Configuration
  home.file.".config/ags" = {
    source = "${selfPkgs.illogical-impulse-ags}";
    recursive = true;
  };
}
