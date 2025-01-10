{ pkgs, ... }: {

  programs.steam = {
    enable = true;
    extraPackages = with pkgs; [ mangohud ];
    gamescopeSession.enable = true;
    protontricks.enable = true;
  };

}
