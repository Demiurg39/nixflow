{lib, ...}:
with lib; {
  imports = [
    ./hardware
    ./users
    ./role
  ];

  options.profiles = with types; {
    hardware = mkOption {
      type = listOf str;
      default = [];
      description = ''A list of hardware-specific modules to import'';
    };

    user = mkOption {
      type = str;
      default = "";
      description = ''Main system user'';
    };

    role = mkOption {
      type = str;
      default = "";
      description = ''Host role'';
      example = "workstation";
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
