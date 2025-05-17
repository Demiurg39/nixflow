{
  config,
  pkgs,
  ...
}: {
  programs.yazi = {
    enable = true;
    enableZshIntegration = config.programs.zsh.enable == true;
    enableNushellIntegration = config.programs.nushell.enable == true;
    # TODO: make further config setup
  };

  home.packages = with pkgs; [
    mediainfo
    exiftool
  ];
}
