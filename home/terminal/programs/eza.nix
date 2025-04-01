{config, ...}: {
  programs.eza = {
    enable = config.programs.zsh.enable == true;
    git = true;
    icons = "auto";
    enableZshIntegration = true;
  };
}
