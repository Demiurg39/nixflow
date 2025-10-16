{...}: {
  services.syncthing = {
    enable = true;
    user = "demi";
    dataDir = "/home/demi"; # default location for new folders
    configDir = "/home/demi/.config/syncthing";
    settings = {
      devices = {
        s24u = {
          id = "5NKQWAY-FBWQNEK-5VNTHA2-ASHIVYY-55YIPQG-XTMEIXF-6KIVOXC-7P62AQH";
        };
      };
      folders = {
        default = {
          enable = true;
          path = "~/Sync";
          devices = [
            "s24u"
          ];
        };
        obsidian = {
          enable = true;
          path = "~/Documents/Obsidian Vault";
          devices = [
            "s24u"
          ];
        };
        keepas = {
          enable = true;
          path = "~/Documents/keepas";
          devices = [
            "s24u"
          ];
        };
      };
    };
  };
}
