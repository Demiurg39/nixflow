{
  inputs,
  self,
  pkgs,
  ...
}: let
  ags = inputs.ags.packages.${pkgs.system}.default.override {
    extraPackages = with pkgs; [
      gtksourceview
      gtksourceview4
      webkitgtk_4_0
      webp-pixbuf-loader
      ydotool
    ];
  };
  selfPkgs = import "${self}/pkgs/illogical-impulse.nix" {
    inherit pkgs ags;
  };
in {
  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    selfPkgs.illogical-impulse-oneui4-icons
    adwaita-qt6
    adw-gtk3
    bibata-cursors
    morewaita-icon-theme
  ];

  home.sessionVariables = {
    XCURSOR_THEME = "Bibata-Modern-Ice";
    XCURSOR_SIZE = 24;
  };

  home.pointerCursor = {
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Ice";
    size = 24;
    gtk.enable = true;
  };

  home.file.".local/share/icons/MoreWaita".source = "${pkgs.morewaita-icon-theme}/share/icons";

  gtk = {
    enable = true;
    iconTheme = {
      package = pkgs.adwaita-icon-theme;
      name = "Adwaita";
    };
  };
  qt = {
    enable = true;
    platformTheme.name = "qt5ct";
    style.name = "kvantum";
  };

  home.file.".config/Kvantum" = {
    source = "${selfPkgs.illogical-impulse-kvantum}";
    recursive = true;
  };
}
