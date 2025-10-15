{
  options,
  config,
  lib,
  ...
}:
with lib; {
  imports = [
    ./profiles
    ./security
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
      description = mkDefault "The primary user account";
      extraGroups = ["wheel"];
      isNormalUser = true;
      home = "/home/${config.user.name}";
      group = "users";
      uid = 1000;
    };
    users.users.${config.user.name} = mkAliasDefinitions options.user;

    # Do not touch
    system.stateVersion = "24.11";
  };
}
