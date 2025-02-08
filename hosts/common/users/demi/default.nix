{
  pkgs,
  config,
  ...
}: let
  ifTheyExists = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in {
  programs.zsh.enable = true;
  # environment.pathsToLink = [ "/share/zsh" ];

  users.users.demi = {
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = ifTheyExists [
      "audio"
      "adbusers"
      "gamemode"
      "networkmanager"
      "video"
      "wheel"
    ];
  };

  home-manager.users.demi = import ../../../../home/demi/${config.networking.hostName}.nix;
}
