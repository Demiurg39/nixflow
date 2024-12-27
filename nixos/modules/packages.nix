{ pkgs, ...}: {

  environment.systemPackages = with pkgs; [
      morewaita-icon-theme
      bibata-cursors
      rubik
      lexend
      twitter-color-emoji
  ];

  environment.gnome.excludePackages = (with pkgs; [
      gedit # text editor
      gnome-photos
      gnome-tour
      gnome-connections
      snapshot
      cheese # webcam tool
      gnome-music
      epiphany # web browser
      geary # email reader
      evince # document viewer
      gnome-characters
      totem # video player
      tali # poker game
      iagno # go game
      hitori # sudoku game
      atomix # puzzle game
      yelp # Help view
      gnome-contacts
      gnome-initial-setup
      gnome-shell-extensions
      gnome-maps
      gnome-font-viewer
    ]);

}
