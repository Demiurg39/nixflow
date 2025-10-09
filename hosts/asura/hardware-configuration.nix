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
  boot.kernelModules = ["kvm-amd" "nvidia_uvm"];
  boot.extraModulePackages = [];

  # TODO: make subvolumes for /nix cause' most root files are symlinks from /nix/store
  fileSystems."/" = {
    device = "/dev/disk/by-uuid/b9eae7f6-9aab-428e-88dc-a9df3dbd72fb";
    fsType = "btrfs";
    options = ["subvol=@" "compress=zstd"];
  };

  fileSystems."/home" = {
    device = "/dev/disk/by-uuid/b9eae7f6-9aab-428e-88dc-a9df3dbd72fb";
    fsType = "btrfs";
    options = ["subvol=@home"];
  };

  fileSystems."/boot" = {
    # device = "/dev/disk/by-uuid/BAB0-8E75";
    device = "/dev/disk/by-label/ESP";
    fsType = "vfat";
    options = ["fmask=0022" "dmask=0022"];
  };

  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
