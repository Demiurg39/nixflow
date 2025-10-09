{
  pkgs,
  system,
  inputs,
  ...
}:
pkgs.mkShell {
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
}
