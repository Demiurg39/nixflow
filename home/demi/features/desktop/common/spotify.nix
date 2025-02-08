{
  inputs,
  pkgs,
  ...
}: let
  inherit (inputs) spicetify-nix;
  spicepkgs = spicetify-nix.legacyPackages.${pkgs.system};
  spotifyTheme = spicepkgs.themes.text;
in {
  imports = [spicetify-nix.homeManagerModules.default];

  programs.spicetify = {
    enable = true;
    enabledExtensions = with spicepkgs.extensions; [
      keyboardShortcut
      fullAppDisplay
      shuffle
    ];

    theme = spotifyTheme;
  };
}
