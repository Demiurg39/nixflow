# translated from zsh to nu by gemini
# nushell completion for nh

module completions {
  # Custom completer for the --shell flag
  def "nu-complete nh completions shell" [] {
    [ "bash", "elvish", "fish", "powershell", "zsh" ]
  }

  # Main command for the nh helper
  export extern "nh" [
    --verbose(-v) # Show debug logs
    --help(-h)    # Print help
    --version(-V) # Print version
  ]

  # NixOS functionality
  export extern "nh os" [
    --verbose(-v) # Show debug logs
    --help(-h)    # Print help (see more with '--help')
  ]

  # Build and activate the new configuration, and make it the boot default
  export extern "nh os switch" [
    flakeref?: path,              # Flake reference to build
    ...extra_args: string,        # Extra arguments passed to nix build
    --diff-provider(-D): string,  # Closure diff provider
    --out-link(-o): path,         # Path to save the result link
    --hostname(-H): string,       # Output to choose from the flakeref
    --specialisation(-s): string, # Name of the specialisation
    --dry(-n)                     # Only print actions, without performing them
    --ask(-a)                     # Ask for confirmation
    --update(-u)                  # Update flake inputs before building
    --no-nom                      # Don't use nix-output-monitor for the build process
    --no-specialisation(-S)       # Don't use specialisations
    --bypass-root-check(-R)       # Bypass the check to call nh as root directly
    --verbose(-v)                 # Show debug logs
    --help(-h)                    # Print help (see more with '--help')
  ]

  # Build the new configuration and make it the boot default
  export extern "nh os boot" [
    flakeref?: path,              # Flake reference to build
    ...extra_args: string,        # Extra arguments passed to nix build
    --diff-provider(-D): string,  # Closure diff provider
    --out-link(-o): path,         # Path to save the result link
    --hostname(-H): string,       # Output to choose from the flakeref
    --specialisation(-s): string, # Name of the specialisation
    --dry(-n)                     # Only print actions, without performing them
    --ask(-a)                     # Ask for confirmation
    --update(-u)                  # Update flake inputs before building
    --no-nom                      # Don't use nix-output-monitor for the build process
    --no-specialisation(-S)       # Don't use specialisations
    --bypass-root-check(-R)       # Bypass the check to call nh as root directly
    --verbose(-v)                 # Show debug logs
    --help(-h)                    # Print help (see more with '--help')
  ]

  # Build and activate the new configuration
  export extern "nh os test" [
    flakeref?: path,              # Flake reference to build
    ...extra_args: string,        # Extra arguments passed to nix build
    --diff-provider(-D): string,  # Closure diff provider
    --out-link(-o): path,         # Path to save the result link
    --hostname(-H): string,       # Output to choose from the flakeref
    --specialisation(-s): string, # Name of the specialisation
    --dry(-n)                     # Only print actions, without performing them
    --ask(-a)                     # Ask for confirmation
    --update(-u)                  # Update flake inputs before building
    --no-nom                      # Don't use nix-output-monitor for the build process
    --no-specialisation(-S)       # Don't use specialisations
    --bypass-root-check(-R)       # Bypass the check to call nh as root directly
    --verbose(-v)                 # Show debug logs
    --help(-h)                    # Print help (see more with '--help')
  ]

  # Build the new configuration
  export extern "nh os build" [
    flakeref?: path,              # Flake reference to build
    ...extra_args: string,        # Extra arguments passed to nix build
    --diff-provider(-D): string,  # Closure diff provider
    --out-link(-o): path,         # Path to save the result link
    --hostname(-H): string,       # Output to choose from the flakeref
    --specialisation(-s): string, # Name of the specialisation
    --dry(-n)                     # Only print actions, without performing them
    --ask(-a)                     # Ask for confirmation
    --update(-u)                  # Update flake inputs before building
    --no-nom                      # Don't use nix-output-monitor for the build process
    --no-specialisation(-S)       # Don't use specialisations
    --bypass-root-check(-R)       # Bypass the check to call nh as root directly
    --verbose(-v)                 # Show debug logs
    --help(-h)                    # Print help (see more with '--help')
  ]

  # Show an overview of the system's info
  export extern "nh os info" [
    --verbose(-v) # Show debug logs
    --help(-h)    # Print help
  ]

  # Home-manager functionality
  export extern "nh home" [
    --verbose(-v) # Show debug logs
    --help(-h)    # Print help
  ]

  # Build and activate a home-manager configuration
  export extern "nh home switch" [
    flakeref?: path,              # Flake reference to build
    ...extra_args: string,        # Extra arguments passed to nix build
    --diff-provider(-D): string,  # Closure diff provider
    --out-link(-o): path,         # Path to save the result link
    --configuration(-c): string,  # Name of the flake homeConfigurations attribute
    --backup-extension(-b): string,# Move existing files by backing up with the extension
    --dry(-n)                     # Only print actions, without performing them
    --ask(-a)                     # Ask for confirmation
    --update(-u)                  # Update flake inputs before building
    --no-nom                      # Don't use nix-output-monitor for the build process
    --verbose(-v)                 # Show debug logs
    --help(-h)                    # Print help (see more with '--help')
  ]

  # Build a home-manager configuration
  export extern "nh home build" [
    flakeref?: path,              # Flake reference to build
    ...extra_args: string,        # Extra arguments passed to nix build
    --diff-provider(-D): string,  # Closure diff provider
    --out-link(-o): path,         # Path to save the result link
    --configuration(-c): string,  # Name of the flake homeConfigurations attribute
    --backup-extension(-b): string,# Move existing files by backing up with the extension
    --dry(-n)                     # Only print actions, without performing them
    --ask(-a)                     # Ask for confirmation
    --update(-u)                  # Update flake inputs before building
    --no-nom                      # Don't use nix-output-monitor for the build process
    --verbose(-v)                 # Show debug logs
    --help(-h)                    # Print help (see more with '--help')
  ]

  # Show an overview of the installation
  export extern "nh home info" [
    --verbose(-v) # Show debug logs
    --help(-h)    # Print help
  ]

  # Searches packages by querying search.nixos.org
  export extern "nh search" [
    query: string,                # Name of the package to search
    --limit(-l): int,             # Number of search results to display
    --channel(-c): string,        # Name of the channel to query (e.g. nixos-23.11)
    --flake(-f): path,            # Flake to read what nixpkgs channels to search for
    --verbose(-v)                 # Show debug logs
    --help(-h)                    # Print help
  ]

  # Enhanced nix cleanup
  export extern "nh clean" [
    --verbose(-v) # Show debug logs
    --help(-h)    # Print help
  ]

  # Cleans root profiles and calls a store gc
  export extern "nh clean all" [
    --keep(-k): int,              # At least keep this number of generations
    --keep-since(-K): string,     # Keep gcroots and generations in this time range
    --dry(-n)                     # Only print actions, without performing them
    --ask(-a)                     # Ask for confirmation
    --nogc                        # Don't run nix store --gc
    --nogcroots                   # Don't clean gcroots
    --verbose(-v)                 # Show debug logs
    --help(-h)                    # Print help
  ]

  # Cleans the current user's profiles and calls a store gc
  export extern "nh clean user" [
    --keep(-k): int,              # At least keep this number of generations
    --keep-since(-K): string,     # Keep gcroots and generations in this time range
    --dry(-n)                     # Only print actions, without performing them
    --ask(-a)                     # Ask for confirmation
    --nogc                        # Don't run nix store --gc
    --nogcroots                   # Don't clean gcroots
    --verbose(-v)                 # Show debug logs
    --help(-h)                    # Print help
  ]

  # Cleans a specific profile
  export extern "nh clean profile" [
    profile: path,                # The profile to clean
    --keep(-k): int,              # At least keep this number of generations
    --keep-since(-K): string,     # Keep gcroots and generations in this time range
    --dry(-n)                     # Only print actions, without performing them
    --ask(-a)                     # Ask for confirmation
    --nogc                        # Don't run nix store --gc
    --nogcroots                   # Don't clean gcroots
    --verbose(-v)                 # Show debug logs
    --help(-h)                    # Print help
  ]

  # Generate shell completion files into stdout
  export extern "nh completions" [
    # Name of the shell to generate completions for
    --shell(-s): string@"nu-complete nh completions shell"
    --verbose(-v) # Show debug logs
    --help(-h)    # Print help
  ]
}

export use completions *
