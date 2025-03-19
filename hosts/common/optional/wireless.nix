{...}: {
  hardware.bluetooth = {
    enable = true;
  };

  services.blueman.enable = true;

  networking = {
    networkmanager.enable = true;
  };
}
