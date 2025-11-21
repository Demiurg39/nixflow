# modules/home.nix -- the $HOME manager
#
# This is NOT a home-manager home.nix file. This NixOS module does two things:
#
# 1. Sets up home-manager (exposing only a subset of its API).
#
# 2. Enforce XDG compliance, whether programs want to or not. #
#
# This was primarly taken from hlissner's cfg
{
  options,
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.home;
in {
  options.home = with types; {
    file = mkOpt' attrs {} "Files to place directly in $HOME";
    configFile = mkOpt' attrs {} "Files to place in $XDG_CONFIG_HOME";
    dataFile = mkOpt' attrs {} "Files to place in $XDG_DATA_HOME";
    fakeFile = mkOpt' attrs {} "Files to place in $XDG_FAKE_HOME";
    mutableConfigFile = mkOpt' attrs {} "Mutable symlinks in $XDG_CONFIG_HOME";

    dir = mkOpt str "${config.user.home}";
    binDir = mkOpt str "${cfg.dir}/.local/bin";
    cacheDir = mkOpt str "${cfg.dir}/.cache";
    configDir = mkOpt str "${cfg.dir}/.config";
    dataDir = mkOpt str "${cfg.dir}/.local/share";
    stateDir = mkOpt str "${cfg.dir}/.local/state";
    fakeDir = mkOpt str "${cfg.dir}/.local/user";

    packages = mkOpt' (listOf package) [] "Home Manager packages to install for the user.";
    programs = mkOpt' attrs {} "Declarative configuration for user programs via home-manager";
    services = mkOpt' attrs {} "Declarative configuration for user services via home-manager";

    extraConfig = mkOpt' attrs {} "Arbitrary, low-priority settings to pass directly to Home Manager.";
  };

  config = {
    environment.sessionVariables = mkOrder 10 {
      # These are the defaults, and xdg.enable does set them, but due to load
      # order, they're not set before environment.variables are set, which
      # could cause race conditions.
      XDG_BIN_HOME = cfg.binDir;
      XDG_CACHE_HOME = cfg.cacheDir;
      XDG_CONFIG_HOME = cfg.configDir;
      XDG_DATA_HOME = cfg.dataDir;
      XDG_STATE_HOME = cfg.stateDir;

      # This is not in the XDG standard. It's my jail stubborn programs,
      # like Firefox, Steam, and LMMS.
      XDG_FAKE_HOME = cfg.fakeDir;
      XDG_DESKTOP_DIR = cfg.fakeDir;
    };

    home.file =
      mapAttrs' (k: v: nameValuePair "${config.home.fakeDir}/${k}" v)
      config.home.fakeFile;

    home-manager = {
      backupFileExtension = "hm-backup";
      useGlobalPkgs = true;
      useUserPackages = true;
      users.${config.user.name} = {...} @ hmArgs:
        lib.mkMerge [
          {
            home = {
              file = mkAliasDefinitions options.home.file;
              packages = mkAliasDefinitions options.home.packages;
              stateVersion = config.system.stateVersion;
            };
            xdg = {
              configFile = mkAliasDefinitions options.home.configFile;
              dataFile = mkAliasDefinitions options.home.dataFile;

              cacheHome = mkForce cfg.cacheDir;
              configHome = mkForce cfg.configDir;
              dataHome = mkForce cfg.dataDir;
              stateHome = mkForce cfg.stateDir;
            };
            programs = mkAliasDefinitions options.home.programs;
            services = mkAliasDefinitions options.home.services;
            dconf.enable = true;
          }

          {
            xdg.configFile =
              mapAttrs (name: path: {
                source = hmArgs.config.lib.file.mkOutOfStoreSymlink path;
              })
              cfg.mutableConfigFile;
          }

          cfg.extraConfig
        ];
    };
  };
}
