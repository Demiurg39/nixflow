{...}: {
  programs.nh = {
    enable = true;
    # ERROR: Cause nixd error (why?)
    # clean = {
    #   enable = true;
    #   extraArgs = "--keep-since 4d --keep 3";
    #   dates = "weekly";
    # };
  };
}
