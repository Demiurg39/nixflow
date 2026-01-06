{
  config,
  inputs,
  pkgs,
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

    programs.spicetify = let
      spicepkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
      spotifyTheme = spicepkgs.themes.dribbblish;
    in {
      enable = true;
      wayland = true; 
      enabledExtensions = with spicepkgs.extensions; [
        # adblock
        aiBandBlocker
        simpleBeautifulLyrics
        betterGenres
        playlisticons
        keyboardShortcut
        shuffle
      ];

      theme = spotifyTheme;
    };
  };
}
