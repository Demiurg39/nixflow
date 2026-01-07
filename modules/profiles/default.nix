{lib, ...}:
with lib; {
  imports = [
    ./hardware
    ./users
    ./role
  ];

  options.modules = with types; {
    profiles = {
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
    };
  };
}
