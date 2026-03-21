{
  imports = [
    ./hardware-configuration.nix
    ./secrets.nix
  ];

  modules = {
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
    };

    nvidia = {
      prime = {
        enable = true;

        amdgpuBusId = "PCI:05:0:0";
        nvidiaBusId = "PCI:01:0:0";
      };
    };

    desktop = {
      niri = {
        enable = true;
        xwayland.enable = true;
        monitors = [
          {
            enable = true;
            output = "eDP-1";
            resolution = "1920x1080";
            refresh_rate = 144.0;
            primary = true;
            vrr.enable = true;
          }
        ];
      };
      gnome.enable = true;
      programs = {
        kanata.enable = true;
        obs-studio.enable = true;
        # syncthing.enable = true;
        ayugram.enable = true;
      };
      browsers.qutebrowser.enable = true;
      browsers.qutebrowser.widevine.enable = true;
      browsers.qutebrowser.setDefault = true;
      terminal = {
        kitty.enable = true;
        shells.nushell.enable = true;
        programs = {
          atuin.enable = true;
          direnv.enable = true;
          yazi.enable = true;
          zoxide.enable = true;
        };
      };
      games = {
        steam.enable = true;
        gamemode.enable = true;
        gamescope.enable = true;
        lutris.enable = true;
      };
      media.spotify.enable = true;
      media.blender.enable = true;
      office.zathura.enable = true;
      office.onlyoffice.enable = true;

      virtualisation.qemu.enable = true;
    };

    development = {
      editors.nvchad.enable = true;
      docker-compose.enable = true;
      databases.postgresql.enable = true;
      #   adb.enable = true;
    };

    system.flatpak.enable = true;

    services.tailscale.enable = true;

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
