{ ... }: {

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = false;
  };

  services.blueman.enable = true;

  networking = {
    networkmanager.enable = true;
  };

}
