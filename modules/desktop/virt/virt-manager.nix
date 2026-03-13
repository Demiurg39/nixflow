{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  cfg = config.modules.desktop.virtualisation.qemu;
in {
  options.modules.desktop.virtualisation.qemu = {
    enable = mkEnableOption "TODO";
  };

  config = mkIf (cfg.enable) {
    programs.virt-manager.enable = true;

    virtualisation = {
      libvirtd = {
        enable = true;
        qemu = {
          package = pkgs.qemu_kvm;
          runAsRoot = true;
          swtpm.enable = true;
          vhostUserPackages = [pkgs.virtiofsd];
        };
      };
      spiceUSBRedirection.enable = true;
    };
    services.spice-vdagentd.enable = true;
  };
}
