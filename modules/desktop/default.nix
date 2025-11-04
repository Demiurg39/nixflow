{lib, ...}:
with lib; {
  imports = [
    ./browsers
    ./terminal
    ./programs
    ./gnome.nix
    ./mangowc.nix
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
