{pkgs, ...}: {
  programs.git = {
    enable = true;
    userName = "Demiurg39";
    userEmail = "chiryagov2014@gmail.com";
  };

  home.packages = with pkgs; [gh];
}
