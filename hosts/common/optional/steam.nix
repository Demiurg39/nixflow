{pkgs, ...}: {
  programs.steam = {
    enable = true;
    extraPackages = with pkgs; [mangohud];
    gamescopeSession.enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    protontricks.enable = true;
  };
}
