{lib, ...}:
with lib; {
  imports = with builtins;
    map (fn: ./${fn})
    (filter (fn: fn != "default.nix") (attrNames (readDir ./.)));

  options.modules.desktop.browser = {
    default = mkOpt (types.nullOr types.str) null;
    spawnCmd = mkOpt' (types.nullOr types.str) null ''
      Command to spawn new instance of browser
    '';
  };
}
