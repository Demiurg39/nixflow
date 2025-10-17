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

    nix = let
      filteredInputs = filterAttrs (_: v: isType "flake" v) inputs;
      nixPathInputs = mapAttrsToList (n: v: "${n}=${v}") filteredInputs;
    in {
      nixPath = nixPathInputs;
      registry = mapAttrs (_: v: {flake = v;}) filteredInputs;
      settings = {
        experimental-features = ["nix-command" "flakes"]; # Enable flakes support
        warn-dirty = false;
        http2 = true;
        trusted-users = ["root" config.user.name];
        allowed-users = ["root" config.user.name];
        auto-optimise-store = true;
      };
    };

    time.timeZone = "Asia/Bishkek";

    # Do not touch
    system.stateVersion = "24.11";
  };
}
