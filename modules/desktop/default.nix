{lib, ...}:
with lib; {
  imports = [
    ./app/kanata.nix
    ./terminal/kitty.nix
    ./terminal/shells/nushell.nix
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
