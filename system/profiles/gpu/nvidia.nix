{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  hardware = config.profiles.hardware;
  cfg = config.profiles.nvidia;
  # primeCfg = config.profiles.nvidia.prime;
in
  mkMerge [
    # For ampere(30 series) and later
    (mkIf
      (any (mod: hasPrefix "gpu/nvidia" mod) hardware)
      {
        services.xserver.videoDrivers = mkDefault ["nvidia"];

        hardware = {
          graphics.extraPackages = [pkgs.vaapiVdpau];

          nvidia = {
            modesetting.enable = lib.mkDefault true;

            # See NixOS/nixos-hardware#348
            powerManagement.enable = true;

            # Use the NVidia open source kernel module (not to be confused with the
            # independent third-party "nouveau" open source driver). Support is
            # limited to the Turing and later architectures. Full list of supported
            # GPUs: https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus
            # Only available from driver 515.43.04+.
            open = mkDefault true;

            # Select the driver version for specific GPU.
            package = config.boot.kernelPackages.nvidiaPackages.stable;
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
        dynamicBoost.enable = cfg.dynamicBoost.enable or false;
        nvidiaPersistenced = mkForce false;

        # Turns off GPU when not in use
        powerManagement.finegrained = true;
      };
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
  ]
