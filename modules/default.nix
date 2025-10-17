{
  options,
  config,
  pkgs,
  lib,
  ...
}:
with lib; {
  imports = [
    ./profiles
    ./security
    ./desktop
    ./development
  ];

  options = with types; {
    user = mkOption {
      type = attrs;
      default = {name = "";};
    };
  };

  config = {
    assertions = [
      {
        assertion = config.user ? name;
        message = "config.user.name is not set!";
      }
    ];

    user = {
      description = mkDefault "Primary user";
      extraGroups = ["wheel"];
      isNormalUser = true;
      home = "/home/${config.user.name}";
      group = "users";
      uid = 1000;
    };
    users.users.${config.user.name} = mkAliasDefinitions options.user;
    environment.variables.FLAKE = "${config.user.home}/nixflow";
    environment.systemPackages = [pkgs.git];

    time.timeZone = "Asia/Bishkek";

    # Do not touch
    system.stateVersion = "24.11";
  };
}
