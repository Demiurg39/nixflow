{
  config,
  pkgs,
  ...
}: let
  ifTheyExists = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in {
  users.users.demi = {
    isNormalUser = true;
    useDefaultShell = true;
    shell = pkgs.nushell;
    extraGroups = ifTheyExists [
      "audio"
      "adbusers"
      "gamemode"
      "libvirtd"
      "networkmanager"
      "input"
      "uinput"
      "video"
      "wheel"
    ];
  };
}
