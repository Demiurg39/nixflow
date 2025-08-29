{
  modulesPath,
  config,
  lib,
  ...
}: {
  imports = [(modulesPath + "/installer/scan/not-detected.nix")];

  boot.initrd.availableKernelModules = ["nvme" "xhci_pci" "usb_storage" "sd_mod"];
  boot.initrd.kernelModules = [];
  boot.kernelParams = ["acpi_backlight=native"];
  boot.kernelModules = ["kvm-amd"];
  boot.extraModulePackages = [];

  # fileSystems."/" = {
  #   device = "/dev/disk/by-uuid/6d47afaa-d20d-4cb5-a72e-4342c710f8be";
  #   fsType = "ext4";
  # };
  #
  # fileSystems."/boot" = {
  #   device = "/dev/disk/by-uuid/6F72-425D";
  #   fsType = "vfat";
  #   options = ["fmask=0077" "dmask=0077"];
  # };
  #
  # fileSystems."/home" = {
  #   device = "/dev/disk/by-uuid/70691b8f-bb45-4239-b9dd-a4dd0d86ea20";
  #   fsType = "ext4";
  # };

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
