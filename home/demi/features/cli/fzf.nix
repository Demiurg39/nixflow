{ config, ... }: {

  programs.fzf = {
    enable = true;
    enableZshIntegration = (config.features.cli.zsh.enable == true);
    # enableNushellIntegration = (config.features.cli.nushell.enable == true); # not exist

    # colors = {};
    
    defaultOptions = [
      "--preview='bat --color=always -n {}'"
      "--bind 'ctrl-/:toggle-preview'"
    ];
    defaultCommand = "fd --type f --exclude .git --follow --hidden";
    changeDirWidgetCommand = "fd --type d --exclude .git --follow --hidden";
  };

}
