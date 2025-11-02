{lib, ...}:
with lib; {
  imports = [
    ./programs/kanata.nix
    ./programs/obs.nix
    ./programs/telegram.nix
    ./terminal
    ./browsers
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
