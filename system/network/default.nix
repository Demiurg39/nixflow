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
      domains = [
        "45.90.28.0#a6d793.dns.nextdns.io"
        "2a07:a8c0::#a6d793.dns.nextdns.io"
        "45.90.30.0#a6d793.dns.nextdns.io"
        "2a07:a8c1::#a6d793.dns.nextdns.io"
      ];
      dnsovertls = "true";
    };
  };
}
