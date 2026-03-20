{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  cfg = config.modules.desktop.gnome;
  hasPrime = config.modules.nvidia.prime.enable;

  extensions = [
    pkgs.gnomeExtensions.appindicator
    pkgs.gnomeExtensions.caffeine
    pkgs.gnomeExtensions.clipboard-indicator
    pkgs.gnomeExtensions.blur-my-shell
    pkgs.gnomeExtensions.just-perfection
    pkgs.gnomeExtensions.rounded-window-corners-reborn
    pkgs.gnomeExtensions.vitals
  ];
in {
  options.modules.desktop.gnome = with types; {
    enable = mkEnableOption "Enable gnome de";
  };

  config = mkIf (cfg.enable) {
    environment.systemPackages = with pkgs;
      [
        papirus-icon-theme
        bibata-cursors
        refine # instead of gnome tweaks
        glib
        gtk3
        gsettings-desktop-schemas
      ]
      ++ extensions;

    services.displayManager.gdm.enable = true;
    services.displayManager.gdm.wayland = true;

    services.desktopManager.gnome.enable = true;

    environment.sessionVariables = {
      XDG_DATA_DIRS = [
        "${pkgs.gtk3}/share/gsettings-schemas/${pkgs.gtk3.name}"
        "${pkgs.gsettings-desktop-schemas}/share/gsettings-schemas/${pkgs.gsettings-desktop-schemas.name}"
      ];
    };

    # Removing unneded gnome packages
    services.gnome.core-developer-tools.enable = false;
    services.gnome.games.enable = false;
    environment.gnome.excludePackages = with pkgs; [
      gnome-tour
      gnome-user-docs
      epiphany # browser
      geary # mail
    ];

    # Gnome multi-gpu setups services
    services.switcherooControl.enable = hasPrime;

    # Enable gnome-like style in qt apps
    qt = {
      enable = true;
      platformTheme = "gnome";
      style = "adwaita-dark";
    };

    # Dconf settings
    programs.dconf.enable = true;
    home.extraConfig.dconf = {
      enable = true;
      settings = {
        # set here colemak-dh as default layout
        # set rus layout
        # and set win_space_toggle
        "org/gnome/desktop/interface" = {
          color-scheme = "prefer-dark";
        };

        # Gnome extensions
        "org/gnome/shell" = {
          disable-user-extensions = false; # Optionally disable user extensions entirely
          enabled-extensions = let
            getUuid = ext:
              if hasAttr "extensionUuid" ext
              then ext.extensionUuid
              else gvariant.mkNothing;
          in (map getUuid extensions);
        };
      };
    };
  };
}
