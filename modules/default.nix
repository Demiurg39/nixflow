{
  options,
  config,
  inputs,
  pkgs,
  self,
  lib,
  ...
}:
with lib; {
  imports = [
    ./desktop
    ./development
    ./profiles
    ./security
    ./home.nix
  ];

  options = with types; {
    flake.configDir = mkOption {
      type = path;
      readOnly = true;
      default = "${self}/config";
      description = "Path to flake config directory";
    };
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
    environment.systemPackages = [pkgs.git pkgs.just];

    programs.nix-ld.enable = true;

    nix = let
      filteredInputs = filterAttrs (_: v: isType "flake" v) inputs;
      nixPathInputs = mapAttrsToList (n: v: "${n}=${v}") filteredInputs;
    in {
      # pin the registry to avoid downloading and evaling a new nixpkgs version every time
      registry = mapAttrs (_: v: {flake = v;}) filteredInputs;
      nixPath = nixPathInputs;

      gc.automatic = true;

      settings = {
        auto-optimise-store = true;
        # use binary cache, its not gentoo
        builders-use-substitutes = true;
        # Enable flakes support
        experimental-features = ["nix-command" "flakes"];
        warn-dirty = false;
        http2 = true;

        trusted-users = ["root" config.user.name];
        allowed-users = ["root" config.user.name];

        # use binary cache, its not gentoo
        substituters = ["https://cache.nixos.org"];
        trusted-public-keys = ["cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="];
      };
    };

    time.timeZone = "Asia/Bishkek";
    nixpkgs.config.allowUnfree = true;

    # Do not touch
    system.stateVersion = "24.11";
  };
}
