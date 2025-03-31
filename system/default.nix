let
  desktop = [
    ./core
    ./core/boot.nix

    ./hardware/fwupd.nix
    ./hardware/graphics.nix

    ./network
    ./network/localsend.nix

    ./programs

    ./services
    ./services/sddm.nix
    ./services/pipewire.nix
  ];

  laptop =
    desktop
    ++ [
      ./hardware/bluetooth.nix
    ];
in {
  inherit desktop laptop;
}
