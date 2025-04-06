{
  inputs,
  pkgs,
  ...
}: let
  spicepkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
  spotifyTheme = spicepkgs.themes.dribbblish;
in {
  imports = [inputs.spicetify-nix.homeManagerModules.default];

  programs.spicetify = {
    enable = true;
    enabledExtensions = with spicepkgs.extensions; [
      adblock
      betterGenres
      keyboardShortcut
      shuffle
    ];

    theme = spotifyTheme;
  };
}
