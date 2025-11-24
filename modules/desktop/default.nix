{lib, ...}:
with lib; let
  desktop_types = ["wayland" "x11"];
in {
  imports = [
    ./browsers
    ./office
    ./terminal
    ./programs
    ./gnome.nix
    ./mangowc.nix
  ];
  options.modules.desktop = with types; {
    type = mkOption {
      type = nullOr (enum desktop_types);
      default = null;
      example = "wayland";
      description = ''Desktop type for defining which using now'';
    };
  };
}
