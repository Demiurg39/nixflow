{
  config,
  inputs,
  lib,
}:
with lib; let
  cfg = config.modules.desktop.mangowc;
in {
  options.modules.desktop.mangowc = with types; {
    enable = mkEnableOption "Whether to enable mangowc window manager";
  };

  config = mkIf (cfg.enable) {
    programs.mango.enable = true;

    home.extraConfig = {
      # Add mango hm module
      imports = [inputs.mango.hmModules.mango];

      wayland.windowManager.mango = {
        enable = true;
        settings = ''
          # see config.conf
        '';
        autostart_sh = ''
          # see autostart.sh
          # Note: here no need to add shebang
        '';
      };
    };
  };
}
