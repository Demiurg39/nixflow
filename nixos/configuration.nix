# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ lib, pkgs, inputs, ... }: {

  imports = [
      ./hardware-configuration.nix
      ./modules
    ];

  # Enable flakes support
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.settings.auto-optimise-store = true;

  # Hostname
  networking.hostName = "nixos";

  # Timezone
  time.timeZone = "Europe/Istanbul";

  # Default locale
  i18n.defaultLocale = "en_US.UTF-8";

  # Home-manager
  # environment.systemPackages = with pkgs; [ home-manager ];

  system.stateVersion = "24.11"; # Do not touch

}
