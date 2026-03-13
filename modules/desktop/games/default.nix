{
  pkgs,
  lib,
  ...
}:
with lib; {
  imports = with builtins;
    map (fn: ./${fn})
    (filter (fn: fn != "default.nix") (attrNames (readDir ./.)));

  options.modules.desktop.games = {
    protonup.package =
      mkOpt' (types.package) pkgs.protonplus
      "Default util for management versions of proton/dxvk/vkd3d and etc";
  };
}
