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
    # pkgs.gnomeExtensions.adaptive-brightness
    # pkgs.gnomeExtensions.blur-my-shell
    # pkgs.gnomeExtensions.appindicator
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
        gnome-tweaks
      ]
      ++ extensions;

    services.displayManager.gdm.enable = true;
    services.displayManager.gdm.wayland = true;

    services.desktopManager.gnome.enable = true;

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
      settings = mkMerge [
        {
          # set here colemak-dh as default layout
          # set rus layout
          # and set win_space_toggle
          "org/gnome/desktop/interface" = {
            accent-color = "blue";
            color-scheme = "prefer-dark";
          };
          "org/gnome/desktop/input-sources" = {
            xkb-options = ["ctrl:nocaps"];
          };

          # Gnome extensions
          "org/gnome/shell" = {
            disable-user-extensions = false; # Optionally disable user extensions entirely
            enabled-extensions = let
              getUuid = ext:
                if hasAttr "extensionUuid" ext
                then ext.extensionUuid
                # NOTE: maybe do something with ext.
                # as i don't know how dconf will react
                # As doc says: Alternatively, you can manually pass UUID as a string.
                # "blur-my-shell@aunetx"
                # ...
                # Maybe tweak with metadata
                else ext;
            in (map getUuid extensions);
          };
        }

        # Configure individual extensions
        (mkIf (any (e: hasAttr "blur-my-shell" e) extensions) {
          "org/gnome/shell/extensions/blur-my-shell" = {
            brightness = 0.75;
            noise-amount = 0;
          };
        })
      ];
    };

    services.flatpak.enable = true;
  };
}
