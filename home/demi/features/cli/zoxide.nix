{config, ...}: {
  programs.zoxide = {
    enable = true;
    enableZshIntegration = config.features.cli.zsh.enable == true;
    enableNushellIntegration = config.features.cli.nushell.enable == true;
    options = ["--cmd cd"];
  };
}
