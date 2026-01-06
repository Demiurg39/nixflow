{
  config,
  inputs,
  lib,
  ...
}:
with lib; let
  cfg = config.modules.desktop.media.spotify;
in {
  options.modules.desktop.media.spotify = {
    enable = mkEnableOption "TODO: ";
  };

  config = mkIf (cfg.enable) {
    home-manager.users.${config.user.name}.imports = [inputs.spicetify-nix.homeManagerModules.default];

    home.programs.spicetify = let
      spicepkgs = inputs.spicetify-nix.legacyPackages.${config.hostPlatform};
      spotifyTheme = spicepkgs.themes.dribbblish;
    in {
      enable = true;
      # wayland = true; 
      enabledExtensions = with spicepkgs.extensions; [
        # adblock
        # aiBandBlocker
        # simpleBeautifulLyrics
        # betterGenres
        # powerBar
        # playlistIcons
        keyboardShortcut
        shuffle
      ];

      theme = spotifyTheme;
    };
  };
}
