{config, ...}: {
  programs.zoxide = {
    enable = true;
    enableZshIntegration = config.programs.zsh.enable == true;
    enableNushellIntegration = config.programs.nushell.enable == true;
    # NOTE: uses default z&zi cmd
    options = [];
  };
}
