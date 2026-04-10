{lib, ...}:
with lib; {
  imports = with builtins;
    map (fn: ./${fn})
    (filter (fn: fn != "default.nix") (attrNames (readDir ./.)));

  options.modules.development.editor = {
    default = mkOpt (types.nullOr types.str) null;
    spawnCmd = mkOpt' (types.nullOr types.str) null ''
      Command to spawn new instance of terminal
      If omitted will use just name of terminal
      from config.modules.desktop.terminal.default
    '';
  };
}
