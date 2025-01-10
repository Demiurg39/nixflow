# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ pkgs, ... }: {

  imports = [
      ./hardware-configuration.nix

      ../common/global
      ../common/users/demi

      ../common/optional/hyprland.nix
      ../common/optional/nvidia-gpu.nix
      ../common/optional/pipewire.nix
      ../common/optional/polkit.nix
      ../common/optional/quietboot.nix
      ../common/optional/sddm.nix
      ../common/optional/ssd.nix
      ../common/optional/steam.nix
      ../common/optional/wireless.nix
    ];

  # hostname
  networking.hostName = "asura";

  # git
  environment.systemPackages = with pkgs; [ git ];

  system.stateVersion = "24.11"; # Do not touch

}
