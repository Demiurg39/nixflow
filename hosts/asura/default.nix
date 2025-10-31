{
  imports = [
    ./hardware-configuration.nix
    ./secrets.nix
  ];

  #         "${mod}/network/localsend.nix"
  #
  #         "${mod}/programs/gamemode.nix"
  #         "${mod}/programs/gaming.nix"
  #         "${mod}/programs/diagnostics.nix"

  modules = {
    profiles = {
      user = "demi";
      role = "workstation/laptop";
      hardware = [
        "cpu/amd"
        "gpu/amd"
        # INFO: temporary removed
        # Cause it need some fixes with suspending
        # "gpu/nvidia"
        "audio"
        "bluetooth"
        "ssd"
        "wifi"
        "zram"
      ];
    };

    nvidia = {
      prime = {
        enable = true;

        amdgpuBusId = "PCI:05:0:0";
        nvidiaBusId = "PCI:01:0:0";
      };
    };

    desktop = {
      # NOTE: maybe try mangowc - https://github.com/DreamMaoMao/mangowc
      # hyprland = {
      #   enable = true;
      #   monitor = ["eDP-1,1920x1080@144,0x0,1"];
      # };
      gnome.enable = true;
      programs = {
        kanata.enable = true;
        # syncthing.enable = true;
        # telegram.enable = true;
      };
      browsers.qutebrowser.enable = true;
      terminal.kitty.enable = true;
      terminal.shells.nushell.enable = true;
      # games.enable = true;
      # office.zathura.enable = true;
      # office.openOffice.enable = true;
    };

    development = {
      editors.nvchad.enable = true;
      docker-compose.enable = true;
      #   databases.postgresql.enable = true;
      networks.packettracer.enable = true;
      #   adb.enable = true;
    };

    # security = {
    #   usbguard = {
    #     enable = true;
    #     rules = [
    #       ''allow id 346d:5678 serial "3025821295868437616"''
    #       ''allow id 048d:1234 serial "2491551056425020931"''
    #       ''allow id 090c:1000 serial "1112043700002018"''
    #       ''allow id 04e8:6860 serial "RFCX41GVWJK"'' # S24
    #     ];
    #   };
    # };
  };
}
