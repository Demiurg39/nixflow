{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  role = config.modules.profiles.role;
in
  mkMerge [
    (mkIf (hasPrefix "workstation" role)
      {
        # services.resolved = {
        #   enable = true;
        #   dnsovertls = "true";
        #   # See systemd/systemd#10579
        #   dnssec = "false";

        # TODO: insert my nextdns server
        # global.dns_servers = [];

        # fallbackDns = [
        #   "9.9.9.9#dns.quad9.net" # Quad9
        #   "1.1.1.1#cloudflare-dns.com" # Cloudflare
        # ];
        #
        # extraConfig = ''
        #   DNSStubListenerExtra=127.0.0.1
        # '';
        # };

        networking.networkmanager = {
          enable = true;
          # Tell NM to let resolved handle DNS
          # dns = "systemd-resolved";
          settings = {
            connection.ethernet-cloned-mac-address = "stable";
          };
        };

        boot = {
          bootspec.enable = true;

          # use latest kernel
          kernelPackages = pkgs.linuxPackages_latest;

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
      services.tlp.enable = !(config.services.power-profiles-daemon.enable || config.services.desktopManager.gnome.enable);

      # For deep-suspend mod
      boot.kernelParams = ["mem_sleep_default=deep"];
    })
  ]
