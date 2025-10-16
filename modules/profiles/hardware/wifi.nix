{
  config,
  lib,
  ...
}:
with lib; let
  hardware = config.profiles.hardware;
in
  mkIf (any (mod: hasPrefix "wifi" mod) hardware) {
    networking = {
      networkmanager = {
        settings = {
          # Use a random MAC for Wi-Fi scanning
          wifi.scan-rand-mac-address = "yes";
          # Use a stable but randomized MAC for each connection
          connection.wifi-cloned-mac-address = "stable";
        };
      };
    };
  }
