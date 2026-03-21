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
  imports =
    [
      ./desktop
      ./development
      ./profiles
      ./security
      ./services/tailscale.nix
      ./system
      ./home.nix
    ]
    ++ [
      inputs.nix-index-database.nixosModules.default
    ];

  options = with types; {
    flake = {
      path = mkOpt' path "${self}" "Path to flake";
      pathStr = mkOpt' str "${config.user.home}/nixflow" "String path to flake";
      configDir = mkOpt' path "${self}/config" "Path to flake config directory (nix-store path)";
      configDirStr = mkOpt' str "${config.user.home}/nixflow/config" "String path to flake config directory (primarly use for mutable links)";
    };
    hostPlatform = mkOpt str "";
    user = mkOpt attrs {name = "";};
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
    environment.variables.NH_FLAKE = config.flake.pathStr;
    environment.systemPackages = [pkgs.git pkgs.just];

    modules.system.ccache.enable = true;
    programs.nix-ld.enable = true;
    programs.nix-index-database.comma.enable = true;
    programs.nh = {
      enable = true;
      clean.enable = true;
      clean.extraArgs = "--keep 3 --keep-since 3d";
    };

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
        # Use binary cache, its not gentoo
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
