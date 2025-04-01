{ lib, fetchFromGitHub, stdenv }:

stdenv.mkDerivation {
  pname = "illogical-impulse-kvantum";
  version = "latest";

  src = fetchFromGitHub {
    owner = "end-4";
    repo = "dots-hyprland";
    rev = "5c396d7548cf1f6d2460e5b1425301d0c960fc50";
    sha256 = "sha256-EMhcIApxaV7X2H88eNWekKDpd56OU7CeWImftlkoM8o=";
  };

  installPhase = ''
    mkdir -p $out
    cp -r $src/.config/Kvantum/* $out/
  '';

  meta = {
    description = "Kvantum theme written by end-4";
    homepage = "https://github.com/end-4/dots-hyprland";
    license = lib.licenses.gpl3;
  };
}
