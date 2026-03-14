{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  nvidia = config.modules.nvidia;
  role = config.modules.profiles.role;
  hardware = config.modules.profiles.hardware;

  # nvidiaBusId = "PCI:01:0:0";
  nvidiaPci = let
    busId = nvidia.prime.nvidiaBusId;
    cleanId = last (splitString "@" (removePrefix "PCI:" busId));
    parts = splitString ":" cleanId;

    pad = s:
      if (stringLength s) < 2
      then "0${s}"
      else s;

    bus = builtins.elemAt parts 0;
    slot = pad (builtins.elemAt parts 1);
    func = builtins.elemAt parts 2;
  in "${bus}:${slot}.${func}";
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
      services.power-profiles-daemon.enable = mkForce false;
      services.tlp.enable = true;
      services.tlp.settings = mkMerge [
        {
          # Change platform profile (Silent on battery)
          PLATFORM_PROFILE_ON_AC = "performance";
          PLATFORM_PROFILE_ON_BAT = "low-power";

          # Disable cpu boos on battery
          CPU_BOOST_ON_AC = 1;
          CPU_BOOST_ON_BAT = 0;

          # --- PCIe & NVMe ---
          # Powersave for SSD and WiFi
          PCIE_ASPM_ON_AC = "default";
          PCIE_ASPM_ON_BAT = "powersupersave";

          # --- Watchdog ---
          # Disable Watchdog
          NMI_WATCHDOG = 0;
        }

        (mkIf (any (mod: hasPrefix "gpu/nvidia" mod) hardware)
          {
            # Set nvidia power management to finegrained
            RUNTIME_PM_ON_AC = "auto";
            RUNTIME_PM_ON_BAT = "auto";
            # Not managing nvidia device
            RUNTIME_PM_DENYLIST = nvidiaPci;
          })

        (mkIf (any (p: hasPrefix "amd_pstate=active" p) config.boot.kernelParams) {
          # amd_pstate tweaks
          CPU_SCALING_GOVERNOR_ON_AC = "performance";
          CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
          CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
          CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
        })
      ];
    })
  ]
