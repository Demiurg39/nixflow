{ inputs, outputs, ... }: {

  imports = [
    inputs.home-manager.nixosModules.home-manager
    ./locale.nix
    ./nix-ld.nix
    ./nix.nix
    ./openssh.nix
    ./sops.nix
  ] ++ builtins.attrValues outputs.nixosModules;


  home-manager.backupFileExtension = "old";
  home-manager.useUserPackages = true;
  home-manager.extraSpecialArgs = { inherit inputs outputs; };

  nixpkgs.config.allowUnfree = true;

  services.libinput.enable = true;
  services.xserver = {
    enable = true;
    xkb = {
      layout = "us";
      variant = "colemak_dh";
    };
  };

  console.useXkbConfig = true;

}
