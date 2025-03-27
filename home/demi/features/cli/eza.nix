{config, ...}: {
  programs.eza = {
    enable = config.features.cli.nushell.enable != true;
    git = true;
    icons = "auto";
    enableZshIntegration = config.features.cli.zsh.enable == true;
  };
}
