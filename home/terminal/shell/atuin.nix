{config, ...}: {
  programs.atuin = {
    enable = true;
    enableZshIntegration = config.programs.zsh.enable == true;
    enableNushellIntegration = config.programs.nushell.enable == true;
  };
}
