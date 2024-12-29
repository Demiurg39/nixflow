{pkgs, ... }: {

  # Steam
  programs.steam = {
    enable = true;
    # remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play 
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
    gamescopeSession.enable = false;
  };
  
  # Lutris
  environment.systemPackages = with pkgs; [
    wineWowPackages.stable
    protonup-qt
    steamtinkerlaunch

    (lutris.override {
      extraLibraries = pkgs: [
      	protobuf
      	dxvk
	vkd3d
	libvdpau
      ];
      extraPkgs = pkgs: [
	gamescope
	mangohud
      ];
    })
  ];

  programs.gamemode.enable = true;

}
