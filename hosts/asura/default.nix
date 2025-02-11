{pkgs, ...}: {
  imports = [
    ./hardware-configuration.nix

    ../common/global
    ../common/users/demi

    ../common/optional/android.nix
    ../common/optional/gamemode.nix
    ../common/optional/hyprland.nix
    ../common/optional/kanata.nix
    ../common/optional/nvidia-gpu.nix
    ../common/optional/pipewire.nix
    ../common/optional/polkit.nix
    ../common/optional/quietboot.nix
    ../common/optional/sddm.nix
    ../common/optional/ssd.nix
    ../common/optional/steam.nix
    ../common/optional/warp.nix
    ../common/optional/wireless.nix
  ];

  # hostname
  networking.hostName = "asura";

  # git
  environment.systemPackages = with pkgs; [git];

  system.stateVersion = "24.11"; # Do not touch
}
