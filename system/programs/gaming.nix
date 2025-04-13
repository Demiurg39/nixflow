{pkgs, ...}: {
  programs = {
    gamescope = {
      enable = true;
      # NOTE: produces error:
      # failed to inherit capabilities: Operation not permitted
      # check https://discourse.nixos.org/t/unable-to-activate-gamescope-capsysnice-option/37843
      capSysNice = false;
      args = [
        "--rt"
        "--expose-wayland"
        "--grab"
        "--force-grab-cursor"
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
