{ inputs, pkgs, lib, ... }: let
  nivix = inputs.nivix.packages.${pkgs.system}.default.extend {
    config.opts = {
      border = lib.mkForce "rounded";
      winblend = lib.mkForce 12;
      transparent = lib.mkForce true;
      lsp_format = lib.mkForce "fallback";

      dashboard = {
        # wall = my-wall; # wallpaper
        symbols = lib.mkForce "sextant";
        fg-only = lib.mkForce false;
      };
    };
  };
in {

  home.packages = [ nivix ];

}
