{...}: {
  imports = [
    ./hardware-configuration.nix
    ./secrets.nix
  ];

  # TODO: move this somewhere more suited for this
  # cause flake might be used not by just this host
  # maybe exporting it somewhere else
  # nh default flake
  # environment.variables.FLAKE = "/home/demi/nixflow";

  #         "${mod}/core/lanzaboote.nix"
  #
  #         "${mod}/hardware/nvidia-laptop.nix"
  #
  #         "${mod}/network/localsend.nix"
  #         "${mod}/network/packettracer.nix"
  #
  #         "${mod}/programs/gamemode.nix"
  #         "${mod}/programs/gaming.nix"
  #         "${mod}/programs/hyprland"
  #         "${mod}/programs/adb.nix"
  #         "${mod}/programs/diagnostics.nix"
  #         "${mod}/programs/arion.nix"
  #
  #         "${mod}/services/kanata"
  #         "${mod}/services/syncthing.nix"
  #         "${mod}/services/postgresql.nix"

  # profiles = {
  #   hardware = [
  #     "bluetooth"
  #     "nvidia"
  #   ];
  # };

  console.keyMap = "mod-dh-ansi-us";

  # for SSD/NVME health
  services.fstrim.enable = true;
}
