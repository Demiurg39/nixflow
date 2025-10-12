{
  pkgs,
  system,
  inputs,
  ...
}:
pkgs.mkShell rec {
  packages = with pkgs; [
    alejandra
    git
    nixd
    inputs.nvchad4nix.packages.${system}.default
    ripgrep
    lazygit
  ];
  name = "flake";
  DIRENV_LOG_FORMAT = "";
  shellHooks = ''
    echo "${name}-shell is started..."
    export EDITOR=nvim
  '';
}
