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

  profiles = {
    user = "demi";
    role = "workstation/laptop";
    hardware = [
      "cpu/amd"
      "gpu/amd"
      "gpu/nvidia"
      "audio"
      "bluetooth"
      "ssd"
      "wifi"
      "zram"
    ];

    nvidia.prime = {
      enable = true;
      amdgpuBusId = "PCI:05:0:0";
      nvidiaBusId = "PCI:01:0:0";
    };
  };

  desktop = {
    # hyprland = {
    #   enable = true;
    #   monitor = ["eDP-1,1920x1080@144,0x0,1"];
    # };
    gnome = {
      enable = true;
    };
    app = {
      kanata.enable = true;
      # syncthing.enable = true;
      # telegram.enable = true;
    };
    browsers.qutebrowser.enable = true;
    # games.enable = true;
  };

  # development = {
  #   docker-compose.enable = true;
  #   databases.postgresql.enable = true;
  #   packettracer.enable = true;
  #   adb.enable = true;
  # };
}
