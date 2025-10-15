{lib, ...}:
with lib; {
  imports = [
    ./gnome.nix
    ./app/kanata.nix
    ./browser
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
