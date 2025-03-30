{...}: {
  networking = {
    nameservers = ["9.9.9.9#dns.quad9.net"];

    networkmanager = {
      enable = true;
      dns = "systemd-resolved";
    };
  };
  services = {
    openssh = {
      enable = true;
      settings.UseDns = true;
    };

    resolved = {
      enable = true;
      dnsovertls = "opportunistic";
    };
  };
}
