{
  config,
  lib,
  ...
}:
with lib; let
  role = config.modules.profiles.role;
in
  mkMerge [
    (mkIf (hasPrefix "workstation" role)
      {
        services.resolved = {
          enable = true;

          settings.Resolve = {
            DNSOverTLS = true;
            # See systemd/systemd#10579
            DNSSEC = false;
            # TODO: insert my nextdns server
            # Quad9 by default
            Domains = ["dns.quad9.net"];
            DNS = ["9.9.9.9 2620:fe::fe"];
            FallbackDNS = ["1.1.1.1#cloudflare-dns.com"];
          };
        };

        networking.networkmanager = {
          enable = true;
          # Tell NM to let resolved handle DNS
          dns = "systemd-resolved";
          settings = {
            connection.ethernet-cloned-mac-address = "stable";
          };
        };

        boot = {
          bootspec.enable = true;
          initrd.compressor = "zstd";

          kernelPackages = config.modules.system.kernel.package;

          kernelParams = [
            "quiet"
            "splash"
            "systemd.show_status=auto"
            "udev.log_level=3"
          ];

          loader = {
            systemd-boot.enable = mkDefault true;
            systemd-boot.configurationLimit = mkDefault 5;
            timeout = mkDefault 1;
            efi.canTouchEfiVariables = true;
          };
        };

        services.openssh.enable = true;
        services.fwupd.enable = true;
      })

    (mkIf (hasPrefix "workstation/laptop" role) {
      services.power-profiles-daemon.enable = true;
    })
  ]
