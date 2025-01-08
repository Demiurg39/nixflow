{ inputs, config, lib, ... }: {
    home = {
        username = lib.mkDefault "demi";
        homeDirectory = lib.mkDefault "/home/${config.home.username}";
        stateVersion = lib.mkDefault "24.05";
        sessionPath = [ "$HOME/.local/bin" ];
        sessionVariable = { FLAKE = "$HOME/nix"; };
    };
}
