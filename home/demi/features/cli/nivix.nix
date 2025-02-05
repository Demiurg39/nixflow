{
  config,
  inputs,
  pkgs,
  ...
}: let
  flake = ''(builtins.getFlake "/home/demi/nixflow")'';
  nivix = inputs.nivix.packages.${pkgs.system}.default.extend {
    plugins.lsp.servers.nixd.settings.options = rec {
      nixos.expr = ''${flake}.nixosConfigurations.asura.options'';
      home-manager.expr = ''${flake}.homeConfigurations.demi.options'';
    };
  };
in {
  home.packages = [nivix];
}
