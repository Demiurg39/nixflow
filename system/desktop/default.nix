{lib, ...}:
with lib; {
  imports = [
    ./app/kanata.nix
    ./app/syncthing.nix
    ./terminal/kitty.nix
    ./browser
    ./gnome.nix
  ];
  options.desktop = with types; {
    type = mkOption {
      type = nullOr str;
      default = null;
      example = "wayland";
      description = ''Desktop type for defining which using now'';
    };
  };
}
