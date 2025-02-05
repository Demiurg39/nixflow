{
  outputs,
  config,
  pkgs,
  lib,
  ...
}: {
  imports =
    [
      # inputs.impermanence.nixosModules.home-manager.impermanence
      ../features/cli
    ]
    ++ (builtins.attrValues outputs.homeManagerModules);

  nix.settings.experimental-features = ["nix-command" "flakes"];
  nix.package = lib.mkDefault pkgs.nix;

  programs.home-manager.enable = true;
  programs.git.enable = true;

  home = {
    username = lib.mkDefault "demi";
    homeDirectory = lib.mkDefault "/home/${config.home.username}";
    stateVersion = lib.mkDefault "24.05";
    sessionPath = ["$HOME/.local/bin"];
    sessionVariables = {FLAKE = "$HOME/nix";};
  };

  nixpkgs.config.allowUnfree = true;
}
