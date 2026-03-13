{pkgs, ...}: {
  imports = with builtins;
    map (fn: ./${fn})
    (filter (fn: fn != "default.nix") (attrNames (readDir ./.)));

  environment.systemPackages = [
    pkgs.unar
    pkgs.unzip
    pkgs.unrar
    pkgs.p7zip
    pkgs.wget
  ];
}
