{
  config,
  lib,
  ...
}: let
  cfg = config.features.cli.nushell;
in {
  options.features.cli.nushell = {
    enable = lib.mkEnableOption "enable Nushell with configuration";
  };

  config = lib.mkIf cfg.enable {
    programs = {
      nushell = {
        enable = true;

        environmentVariables = {
          SUDO_PROMPT = "$'\033[32;05;16m %u\033[0m password -> '";
          TERMINAL = "kitty";
          BROWSER = "librewolf";
          VISUAL = "vi";
          EDITOR = "vi";
        };

        configFile.source = ./config.nu;

        shellAliases = {
          grep = "grep --color=auto";
          "git log" = "git log --oneline";
          lgit = "lazygit";
          mv = "mv -v";
          rm = "rm -v";
          yz = "yazi";
          diff = "diff --color";
          stl = "steamtinkerlaunch";
          ll = "ls -l";
          cl = "clear";
          ff = "fastfetch";

          # Nixos specific
          boot = "nh os boot";
          switch = "nh os switch";
          rebuild = "nh os test";
          # check = "nix flake check ${flake-dir}";
          # update = "nix flake update --flake ${flake-dir}";
          # upgrade = "nixos-rebuild test --upgrade --use-remote-sudo --flake ${flake-dir}";
          # garbage = "sudo nix-collect-garbage --delete-older-than 7d && nix-collect-garbage -d && nix-store --gc";
          list-generations = "sudo nix-env -p /nix/var/nix/profiles/system --list-generations";
        };
      };

      carapace = {
        enable = true;
        enableNushellIntegration = true;
      };
    };
  };
}
