{lib, ...}:
with lib; {
  imports = [
    ./app/kanata.nix
    ./app/syncthing.nix
    ./terminal/kitty.nix
    ./terminal/nushell.nix
    ./browser
    ./gnome.nix
  ];
  options.modules.desktop = with types; {
    type = mkOption {
      type = nullOr str;
      default = null;
      example = "wayland";
      description = ''Desktop type for defining which using now'';
    };
  };
}
