# config.nu
#
# Installed by:
# version = "0.101.0"
#
# This file is used to override default Nushell settings, define
# (or import) custom commands, or run any other startup tasks.
# See https://www.nushell.sh/book/configuration.html
#
# This file is loaded after env.nu and before login.nu

# Variables {

$env.config.buffer_editor = "vi"
$env.config.edit_mode = "vi"
$env.config.show_banner = false

const NU_LIB_DIRS = [
  ($nu.home-path | path join "nixflow/home/terminal/shell/nushell")
]

const NU_PLUGIN_DIRS = [
  ($nu.current-exe | path dirname)
  ($nu.data-dir | path join 'plugins' | path join (version).version)
  ($nu.config-path | path dirname | path join 'plugins')
]

{
  SUDO_PROMPT: $"(ansi blue)%u(ansi reset) password -> ",
  FLAKE: ($env.home | path join "nixflow"),
  TERMINAL: "kitty",
  BROWSER: "librewolf",
  VISUAL: "vi",
  EDITOR: "vi",
} | load-env

# }

# Hooks {

$env.config = ($env.config | upsert hooks {
  pre_prompt: [
    {
      # Use the generated color scheme
      let color_file = "/home/demi/.cache/ags/user/generated/terminal/sequences.txt"
      if ( $color_file | path exists) {
        open $color_file | print
      }
    }
  ]

  command_not_found: {
    |command_name|
    print (nix-index $command_name | str trim)
  }
})

# }

# Custom commands {

source extract.nu

# }


# Aliases {

alias "cl" = clear
alias "grep" = grep --color=auto;
alias "git log" = git log --oneline;
alias "lgit" = lazygit;
alias "mv" = mv -v;
alias "rm" = rm -v;
alias "diff" = diff --color;
alias "stl" = steamtinkerlaunch;
alias "ll" = ls -l;
alias "cl" = clear;
alias "ff" = fastfetch;

# # Nixos specific
alias "boot" = nh os boot;
alias "switch" = nh os switch;
alias "rebuild" = nh os test;
alias "check" = nix flake check ($env.FLAKE);
# alias "update" = nh os test -u;
# alias "garbage" = sudo nix-collect-garbage --delete-older-than 7d ; nix-collect-garbage -d ; nix-store --gc;
alias "list-generations" = sudo nix-env -p /nix/var/nix/profiles/system --list-generations;

# }
