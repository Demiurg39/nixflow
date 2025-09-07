{
  pkgs,
  self,
  ...
}: {
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    git
    gh
  ];

  # Necessary for using flakes on this system.
  nix.settings.experimental-features = "nix-command flakes";

  # Enable alternative shell support in nix-darwin.
  # programs.fish.enable = true;

  font.packages = with pkgs; [
    nerd-fonts.fira-code
    nerd-fonts.jetbrains-mono
  ];

  homebrew = {
    enable = true;
    brews = [
      "mas"
      "kanata"
    ];
    casks = [];
    masApps = [];
    onActivation = {
      # cleanup = "zap";
      autoUpdate = true;
      upgrade = true;
    };
  };

  system.defaults = {
    dock.autoHide = true;
    NSGlobalDomain = {
      AppleInterfaceStyle = "Dark";
    };
  };

  # Set Git commit hash for darwin-version.
  system.configurationRevision = self.rev or self.dirtyRev or null;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 6;

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "aarch64-darwin";
}
