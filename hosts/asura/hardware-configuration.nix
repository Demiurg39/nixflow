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
  boot.supportedFilesystems = ["btrfs"];
  boot.extraModulePackages = [];

  services.btrfs.autoScrub = {
    enable = true;
    interval = "monthly";
    fileSystems = ["/"];
  };

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/b9eae7f6-9aab-428e-88dc-a9df3dbd72fb";
    fsType = "btrfs";
    options = ["subvol=@" "compress=zstd" "noatime"];
  };

  fileSystems."/home" = {
    device = "/dev/disk/by-uuid/b9eae7f6-9aab-428e-88dc-a9df3dbd72fb";
    fsType = "btrfs";
    options = ["subvol=@home" "compress=zstd" "noatime"];
  };

  fileSystems."/nix" = {
    device = "/dev/disk/by-uuid/b9eae7f6-9aab-428e-88dc-a9df3dbd72fb";
    fsType = "btrfs";
    options = ["subvol=@nix" "compress=zstd" "noatime"];
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-label/ESP";
    fsType = "vfat";
    options = ["fmask=0022" "dmask=0022"];
  };
}
