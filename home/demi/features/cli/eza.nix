{config, ...}: {
  programs.eza = {
    enable = true;
    git = true;
    icons = "auto";
    enableZshIntegration = config.features.cli.zsh.enable == true;
    enableNushellIntegration = config.features.cli.nushell.enable == true;
  };
}
