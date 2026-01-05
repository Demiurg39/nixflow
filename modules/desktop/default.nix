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
    ./office
    ./terminal
    ./programs
    ./gnome.nix
    ./mangowc.nix
    ./virt/virt-manager.nix
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
