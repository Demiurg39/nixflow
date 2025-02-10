{ lib, stdenv, fetchFromGitHub }: 

stdenv.mkDerivation {
  pname = "illogical-impulse-oneui4-icons";
  version = "unstable-2024-01-05";
  
  src = fetchFromGitHub {
    owner = "end-4";
    repo = "OneUI4-Icons";
    rev = "9ba21908f6e4a8f7c90fbbeb7c85f4975a4d4eb6";
    sha256 = "sha256-f5t7VGPmD+CjZyWmhTtuhQjV87hCkKSCBksJzFa1x1Y=";
  };
  
  installPhase = ''
    install -d $out/share/icons
    cp -dr --no-preserve=mode OneUI{,-dark,-light} $out/share/icons/
  '';
  
  meta = {
    description = "A fork of mjkim0727/OneUI4-Icons for illogical-impulse dotfiles.";
    homepage = "https://github.com/end-4/OneUI4-Icons";
    license = lib.licenses.gpl3;
  };
}
