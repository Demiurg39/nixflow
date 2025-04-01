{self, ...}: let
  home = "${self}/home";
in {
  imports = [
    "${home}/editors/nvchad.nix"

    "${home}/programs"
    "${home}/programs/games"

    "${home}/programs/wayland"
    "${home}/programs/wayland/hyprland"

    "${home}/terminal/programs"
    "${home}/terminal/emulators/kitty.nix"

    "${home}/terminal/shell/nushell"
    "${home}/terminal/shell/atuin.nix"
    "${home}/terminal/shell/zoxide.nix"

    "${home}/services/media/playerctl.nix"

    "${home}/services/system/polkit-agent.nix"
    "${home}/services/system/udiskie.nix"

    "${home}/services/wayland/hypridle.nix"
    "${home}/services/wayland/wlsunset.nix"
  ];

  wayland.windowManager.hyprland.settings.monitor = [
    "eDP-1,1920x1080@144,0x0,1"
  ];
}
