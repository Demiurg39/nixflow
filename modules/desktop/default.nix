{lib, ...}:
with lib; {
  imports = [
    ./programs/kanata.nix
    ./programs/obs.nix
    ./programs/telegram.nix
    ./terminal/kitty.nix
    ./terminal/shells/nushell.nix
    ./browsers
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
