{
  inputs,
  pkgs,
  ...
}: let
  spicepkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
  spotifyTheme = spicepkgs.themes.text;
in {
  imports = [inputs.spicetify-nix.homeManagerModules.default];

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
