{ config, ... }: {

  programs.yazi = {
    enable = true;
    enableZshIntegration = (config.features.cli.zsh.enable == true);
    enableNushellIntegration = (config.features.cli.nushell.enable == true);
    # TODO: make further config setup
  };

}
