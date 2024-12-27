{ users, pkgs, ... }: {
  programs.zsh.enable = true;
  environment.pathsToLink = [ "/share/zsh" ];

  users.defaultUserShell = pkgs.zsh;
  users.users. demi = {
      home = "/home/demi";
      isNormalUser = true;
      extraGroups = [ "wheel" "networkmanager" ]; # Enable ‘sudo’ for the user.
    };
}
