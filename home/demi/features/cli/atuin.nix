{ config, ... }: {

  programs.atuin = {
    enable = true;
    enableZshIntegration = (config.features.cli.zsh.enable == true);
    enableNushellIntegration = (config.features.cli.nushell.enable == true);
  };

}
