{
  config,
  lib,
  ...
}:
with lib; let
  desktop_types = ["wayland" "x11"];
in {
  imports = [
    ./browsers
    ./media
    ./office
    ./terminal
    ./programs
    ./virt/virt-manager.nix
    ./axshell.nix
    ./gnome.nix
    ./hyprland.nix
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

  config = mkMerge [
    (mkIf (config.modules.desktop.type == "wayland") {
      home.services.cliphist = {
        enable = true;
        extraOptions = [
          "-max-dedupe-search"
          "20"
          "-max-items"
          "500"
        ];
      };
    })

    (mkIf (config.modules.desktop.type == "x11") {})
  ];
}
