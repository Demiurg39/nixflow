{config, ...}: {
  programs.direnv = {
    enable = true;
    enableZshIntegration = config.programs.zsh.enable == true;
    enableNushellIntegration = config.programs.nushell.enable == true;
    nix-direnv.enable = true;
  };
}
