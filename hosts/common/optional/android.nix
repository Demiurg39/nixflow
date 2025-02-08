{pkgs, ...}: {
  programs.adb.enable = true;

  environment.systemPackages = with pkgs; [localsend];
  networking.firewall.allowedTCPPorts = [53317]; # for localsend
}
