{pkgs, ...}: {
  programs = {
    nushell = {
      enable = true;
      configFile.source = ./config.nu;
      extraEnv = ''
        $env.CARAPACE_BRIDGES = 'zsh,fish,bash' # optional
        mkdir ~/.cache/carapace
      '';
    };
  };

  home.packages = with pkgs; [
    bash
    carapace
    fish
    zsh
  ];
}
