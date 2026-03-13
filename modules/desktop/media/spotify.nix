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
    home.modules = [inputs.spicetify-nix.homeManagerModules.default];

    home.programs.spicetify = let
      spicepkgs = inputs.spicetify-nix.legacyPackages.${config.hostPlatform};
    in {
      enable = true;
      wayland = true;
      enabledExtensions = with spicepkgs.extensions; [
        betterGenres
        keyboardShortcut
        shuffle
      ];

      theme = spicepkgs.themes.defaultDynamic;
    };
  };
}
