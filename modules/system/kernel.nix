{
  inputs,
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.system.kernel;
in {
  options.modules.system.kernel = {
    package = mkOpt types.raw pkgs.cachyosKernels.linuxPackages-cachyos-bore;
  };

  config = {
    nixpkgs.overlays = [inputs.nix-cachyos-kernel.overlays.default];
    # NOTE: Reject binary - return to gentoo
    # nix.settings.substituters = ["https://attic.xuyh0120.win/lantian"];
    # nix.settings.trusted-public-keys = ["lantian:EeAUQ+W+6r7EtwnmYjeVwx5kOGEBpjlBfPlzGlTNvHc="];

    # TODO: add options to patch kernel with different options
    # lto, scheduler, bbr, maybe structured config, or add
    # some assert for example to not exclude amd/intel support
    # on amd/intel based hosts
    # cfg.package = let
    #   kernel = pkgs.cachyosKernels.linux-cachyos-latest-x86_64-v3.override {
    #     cpusched = "bore";
    #     lto = "none";
    #     bbr3 = true;
    #
    #     structuredConfig = with lib.kernel; {
    #       CPU_SUP_INTEL = no;
    #       CPU_SUP_CENTAUR = no;
    #       CPU_SUP_ZHAOXIN = no;
    #       HYPERV = no;
    #       FLOPPY = no;
    #       PARPORT = no;
    #       AGP = no;
    #       KERNEL_ZSTD = yes;
    #       X86_CHECK_CPU = no;
    #       DEBUG_INFO = no;
    #       UNUSED_KSYMS_WHITELIST = "";
    #     };
    #   };
    # in
    #   pkgs.linuxKernel.packagesFor kernel;
  };
}
