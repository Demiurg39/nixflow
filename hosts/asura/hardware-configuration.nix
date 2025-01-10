{ config, lib, pkgs, modulesPath, ... }: {

  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelParams = [ "acpi_backlight=native" ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];

  boot.loader.grub = {
      enable = true;
      efiSupport = true;
      device = "nodev";
  };

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/6d47afaa-d20d-4cb5-a72e-4342c710f8be";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/6F72-425D";
      fsType = "vfat";
      options = [ "fmask=0077" "dmask=0077" ];
    };

  fileSystems."/home" =
    { device = "/dev/disk/by-uuid/70691b8f-bb45-4239-b9dd-a4dd0d86ea20";
      fsType = "ext4";
    };

  zramSwap = {
    enable = true;
    algorithm = "lz4";
    priority = 999;
  };

  networking.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  hardware.graphics.enable = true;
  hardware.graphics.enable32Bit = true;

}
