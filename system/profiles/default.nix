{lib, ...}:
with lib; {
  imports = [
    ./cpu/amd.nix
    ./gpu/amd.nix
    ./gpu/nvidia.nix
  ];

  options.profiles = with types; {
    hardware = mkOption {
      type = listOf str;
      default = [];
      description = ''A list of hardware-specific modules to import'';
    };

    nvidia.prime = {
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
        example = "PCI:05:0:0";
        description = ''
          The PCI Bus ID of the discrete NVIDIA GPU.
          This is required to configure PRIME Render Offload.
        '';
      };
    };
  };
}
