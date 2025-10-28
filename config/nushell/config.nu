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

$env.config.buffer_editor = "nvim"
$env.config.edit_mode = "vi"
$env.config.show_banner = false
$env.CARAPACE_BRIDGES = 'zsh,fish,bash' # optional
$env.XDG_CACHE_HOME = $nu.home-path + "/.cache"  # optional

const NU_LIB_DIRS = [
  ($nu.home-path | path join "nixflow/home/terminal/shell/nushell")
]

const NU_PLUGIN_DIRS = [
  ($nu.current-exe | path dirname)
  ($nu.data-dir | path join 'plugins' | path join (version).version)
  ($nu.config-path | path dirname | path join 'plugins')
]

load-env {
  SUDO_PROMPT: $"(ansi blue)%u(ansi reset) password -> ",
  FLAKE: ($env.home | path join "nixflow"),
  TERMINAL: "kitty",
  BROWSER: "librewolf",
  VISUAL: "nvim",
  EDITOR: "nvim",
}

    $env.config = ($env.config | upsert hooks {
      pre_prompt: [
    #     {
    #       # Use the generated color scheme
    #       let color_file = "/home/demi/.cache/ags/user/generated/terminal/sequences.txt"
    #       if ( $color_file | path exists) {
    #         open $color_file | print
    #       }
    #     }
        {
          if (which direnv | is-empty) {
            return
          }

          direnv export json | from json | default {} | load-env
          if 'ENV_CONVERSIONS' in $env and 'PATH' in $env.ENV_CONVERSIONS {
            $env.PATH = do $env.ENV_CONVERSIONS.PATH.from_string $env.PATH
          }
        }
      ]
#      FIXME:
#      command_not_found: {
#        |command_name|
#        print (${lib.getExe pkgs.zsh} -c "${pkgs.nix-index}/etc/profile.d/command-not-found.sh $command_name" | str trim)
#      }
    })

# }

# Sources {

source extract.nu
source completions.nu

# }

# Aliases {

alias "cl" = clear
alias "grep" = grep --color=auto;
alias "lgit" = lazygit;
alias "mv" = mv -v;
alias "rm" = rm -v;
alias "diff" = diff --color;
alias "stl" = steamtinkerlaunch;
alias "ll" = ls -l;
alias "cl" = clear;
alias "ff" = fastfetch;
alias "v" = nvim;
alias "vi" = nvim;
alias "vim" = nvim;

# # Nixos specific
alias "boot" = nh os boot;
alias "switch" = nh os switch;
alias "rebuild" = nh os test;
alias "check" = nix flake check ($env.FLAKE);
# alias "update" = nh os test -u;
# alias "garbage" = sudo nix-collect-garbage --delete-older-than 7d ; nix-collect-garbage -d ; nix-store --gc;
alias "list-generations" = sudo nix-env -p /nix/var/nix/profiles/system --list-generations;

def --env yy [...args] {
	let tmp = (mktemp -t "yazi-cwd.XXXXXX")
	yazi ...$args --cwd-file $tmp
	let cwd = (open $tmp)
	if $cwd != "" and $cwd != $env.PWD {
		cd $cwd
	}
	rm -fp $tmp
}

# }

source zoxide.nu
source nh.nu
source ~/.local/share/atuin/init.nu
source ~/.local/share/atuin/completions.nu
