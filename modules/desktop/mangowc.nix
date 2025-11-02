{
  config,
  inputs,
  pkgs,
  lib,
  ...
}:
with lib; let
  cfg = config.modules.desktop.mangowc;

  monitors = concatStringsSep "\n" (map (
      v:
        if v.disable
        then ""
        else
          replaceStrings ["\n" " "] ["" ""] ''
            monitorrule=${v.output},${toString v.mfact},${toString v.nmaster},${v.layout},
            ${toString v.transform},${toString v.scale},${toString v.x},${toString v.y},
            ${v.width},${v.height},${v.refresh_rate}
          ''
    )
    cfg.monitors);
in {
  imports = [inputs.mango.nixosModules.mango];

  options.modules.desktop.mangowc = with types; {
    enable = mkEnableOption "Whether to enable mangowc window manager";
    extraConfig = mkOpt lines "";
    monitors = mkOpt (listOf (submodule {
      options = {
        output = mkOpt str "";
        mfact = mkOpt float 0.55;
        nmaster = mkOpt int 1;
        layout = mkOpt str "tile";
        transform = mkOpt float 0.0;
        scale = mkOpt float 1.0;
        x = mkOpt int 0;
        y = mkOpt int 0;
        width = mkOpt str "1920";
        height = mkOpt str "1080";
        refresh_rate = mkOpt str "60";
        disable = mkOpt bool false;
      };
    })) [{}];
  };

  config = mkIf (cfg.enable) {
    programs.mango.enable = true;
    modules.desktop.type = "wayland";

    # Add mango hm module
    home-manager.users.${config.user.name}.imports = [inputs.mango.hmModules.mango];

    home.configFile."mango/rule.conf".source = ''${config.flake.configDir}/mango/rule.conf'';
    home.configFile."mango/bind.conf".text = ''${config.flake.configDir}/mango/bind.conf'';
    home.configFile."uwsm/env".source = ''${config.flake.configDir}/mango/env.conf'';

    home.packages = with pkgs; [
      fuzzel
    ];

    home.extraConfig = {
      wayland.windowManager.mango = {
        enable = true;
        systemd.enable = true;
        settings =
          ''
            # see config.conf
            # ${monitors}

            source=~/.config/mango/bind.conf
            source=~/.config/mango/env.conf
            source=~/.config/mango/rule.conf
          ''
          + readFile "${config.flake.configDir}/mango/config.conf";
        # NOTE: here no need to add shebang
        autostart_sh =
          ''
            # see autostart.sh
          ''
          + readFile "${config.flake.configDir}/mango/autostart.sh";
      };
    };
  };
}
