{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  cfg = config.modules.nvidia;
  profiles = config.modules.profiles;
  hardware = config.modules.profiles.hardware;
  nvidia-offload = pkgs.writeShellScriptBin "nvidia-offload" ''
    export __NV_PRIME_RENDER_OFFLOAD=1
    export __NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0
    export __GLX_VENDOR_LIBRARY_NAME=nvidia
    export __VK_LAYER_NV_optimus=NVIDIA_only

    export LD_LIBRARY_PATH=/run/opengl-driver/lib:/run/opengl-driver-32/lib:$LD_LIBRARY_PATH

    exec "$@"
  '';
in {
  options.modules.nvidia = with types; {
    dynamicBoost.enable = mkEnableOption "NVIDIA dynamic boost enable";

    open = mkEnableOption ''
      Use the NVidia open source kernel module
    '';

    prime = {
      enable = mkEnableOption "NVIDIA PRIME Render Offload";
      amdgpuBusId = mkOption {
        type = str;
        default = "";
        example = "PCI:05:0:0";
        description = ''
          The PCI Bus ID of the integrated AMD GPU.
          This is required to configure PRIME Render Offload.
        '';
      };
      nvidiaBusId = mkOption {
        type = str;
        default = "";
        example = "PCI:01:0:0";
        description = ''
          The PCI Bus ID of the discrete NVIDIA GPU.
          This is required to configure PRIME Render Offload.
        '';
      };
    };
  };

  config = mkMerge [
    # For ampere(30 series) and later
    (mkIf
      (any (mod: hasPrefix "gpu/nvidia" mod) hardware)
      {
        services.xserver.videoDrivers = ["nvidia"];
        user.extraGroups = ["video"];
        boot.kernelModules = ["nvidia_uvm"];
        boot.blacklistedKernelModules = ["nouveau"];
        environment.systemPackages = [nvidia-offload];
        boot.extraModprobeConfig = ''
          options nvidia "NVreg_DynamicPowerManagement=0x02"
          options nvidia "NVreg_PreserveVideoMemoryAllocations=1"
        '';

        hardware = {
          graphics.enable = true;
          graphics.extraPackages = [pkgs.libva-vdpau-driver];

          nvidia = {
            modesetting.enable = lib.mkDefault true;

            # See NixOS/nixos-hardware#348
            powerManagement.enable = true;

            # Use the NVidia open source kernel module (not to be confused with the
            # independent third-party "nouveau" open source driver). Support is
            # limited to the Turing and later architectures. Full list of supported
            # GPUs: https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus
            # Only available from driver 515.43.04+.
            open = mkDefault cfg.open;

            # Select the driver version for specific GPU.
            package = config.boot.kernelPackages.nvidiaPackages.production;
          };
        };
      })

    (mkIf (cfg.prime.enable) {
      hardware.nvidia = {
        prime = {
          offload = {
            enable = true;
            enableOffloadCmd = true;
          };

          amdgpuBusId = cfg.prime.amdgpuBusId;
          nvidiaBusId = cfg.prime.nvidiaBusId;
        };

        # Boost balances power between the CPU and the GPU for improved
        # performance on supported laptops using the nvidia-powerd daemon.
        # see the NVIDIA docs, on Chapter 23. Dynamic Boost on Linux.
        dynamicBoost.enable = cfg.dynamicBoost.enable;
        nvidiaPersistenced =
          if profiles.role == "workstation/laptop"
          then mkDefault false
          else mkDefault true;

        # Turns off GPU when not in use
        powerManagement.finegrained = true;
      };

      services.udev.extraRules = ''
        ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x040300", ATTR{power/control}="auto"
        ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x0c0330", ATTR{power/control}="auto"
        ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x0c8000", ATTR{power/control}="auto"
        ACTION=="bind", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x030000", TEST=="power/control", ATTR{power/control}="auto"
        ACTION=="bind", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x030200", TEST=="power/control", ATTR{power/control}="auto"
      '';
    })
    {
      assertions = [
        {
          assertion = !cfg.prime.enable || ((cfg.prime.amdgpuBusId != "") && (cfg.prime.nvidiaBusId != ""));
          message = ''
            When profiles.nvidia.prime is enabled, you must specify both
            `profiles.nvidia.prime.amdgpuBusId` and `profiles.nvidia.prime.nvidiaBusId`.
          '';
        }
      ];
    }
  ];
}
