{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  cfg = config.modules.system.ccache;
in {
  options.modules.system.ccache = {
    enable = mkEnableOption "Whether to enable ccache";
  };

  config = mkIf cfg.enable {
    programs.ccache.enable = true;
    environment.systemPackages = [pkgs.ccache];

    # Enable ccache
    nix.settings.extra-sandbox-paths = [config.programs.ccache.cacheDir];
    nixpkgs.overlays = [
      (self: super: {
        ccacheWrapper = super.ccacheWrapper.override {
          extraConfig = ''
            export CCACHE_COMPRESS=1
            export CCACHE_DIR="${config.programs.ccache.cacheDir}"
            export CCACHE_UMASK=007
            export CCACHE_SLOPPINESS=file_macro,time_macros,include_file_mtime,include_file_ctime,random_seed
            export CCACHE_MAXSIZE="20G"
            if [ ! -d "$CCACHE_DIR" ]; then
            echo "====="
            echo "Directory '$CCACHE_DIR' does not exist"
            echo "Please create it with:"
            echo "  sudo mkdir -m0770 '$CCACHE_DIR'"
            echo "  sudo chown root:nixbld '$CCACHE_DIR'"
            echo "====="
            exit 1
            fi
            if [ ! -w "$CCACHE_DIR" ]; then
            echo "====="
            echo "Directory '$CCACHE_DIR' is not accessible for user $(whoami)"
            echo "Please verify its access permissions"
            echo "====="
            exit 1
            fi
          '';
        };
      })
    ];
  };
}
