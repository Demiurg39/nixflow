{pkgs, ...}: {
  programs = {
    gamescope = {
      enable = true;
      capSysNice = true;
      args = [
        "--rt"
        "--expose-wayland"
      ];
    };

    steam = {
      enable = true;
      extraPackages = with pkgs; [mangohud];
      extraCompatPackages = with pkgs; [proton-ge-bin];
      gamescopeSession.enable = true;
      remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
      protontricks.enable = true;
    };
  };
}
