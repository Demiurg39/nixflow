{pkgs, ...}: {
  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
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
}
