{ config, pkgs, ... }: {

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    dotDir = ".config/zsh";

    history = {
      append = true;
      ignoreAllDups = true;
      ignoreSpace = true;
      share = true;
      save = 10000;
      size = 10000;
      path = "${config.xdg.cacheHome}/zsh/zhistory";
    };

    initExtraFirst = ''autoload -Uz promptinit && promptinit '';

    completionInit = ''
      autoload -Uz compinit
      zstyle ':completion:*' menu select
      zstyle ':completion:*' menu yes select
      zstyle ':completion:*' sort false
      zstyle ':completion:*' completer _complete _match _approximate
      zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*'
      zstyle ':completion:*' special-dirs true
      zstyle ':completion:*' rehash true
      zstyle ':completion:*' list-grouped false
      zstyle ':completion:*' list-separator '''
      zstyle ':completion:*' group-name '''
      zstyle ':completion:*' verbose yes
      zstyle ':completion:*' file-sort modification
      zstyle ':completion:*' list-colors ''${(s.:.)LS_COLORS}
      zstyle ':completion:*:matches' group 'yes'
      zstyle ':completion:*:warnings' format '%F{red}%B-- No match for: %d --%b%f'
      zstyle ':completion:*:messages' format '%d'
      zstyle ':completion:*:corrections' format '%B%d (errors: %e)%b'
      zstyle ':completion:*:descriptions' format '[%d]'
      zstyle ':completion:*:match:*' original only
      zstyle ':completion:*:approximate:*' max-errors 1 numeric
      zstyle ':completion:*:functions' ignored-patterns '(_*|pre(cmd|exec))'
      zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters
      zstyle ':completion:*:jobs' numbers true
      zstyle ':completion:*:jobs' verbose true
      zstyle ':completion:*:git-checkout:*' sort false
      zstyle ':completion:*:eza' sort false
      zstyle ':completion:complete:*:options' sort false
      zstyle ':completion:files' sort false
      zmodload zsh/zle
      zmodload zsh/zpty
      zmodload zsh/complist
      # compinit -ic &
      _comp_options+=(globdots)

      autoload -Uz colors && colors
    '';

    initExtra = ''
      ZSH_AUTOSUGGEST_USE_ASYNC="true"

      extract() {
          if [ -z "$1" ]; then
              # display usage if no parameters given
              echo "Usage: extract <path/file_name>.<zip|rar|gz|tar|7z|tar.bz2|tar.gz|tar.xz>"
              echo "       extract <path/file_name_1.ext> [path/file_name_2.ext] [path/file_name_3.ext]"
          else
              for n in "$@"
              do
                  if [ -f "$n" ]; then
                      case "''${n$,}" in
                        *.tar|*.tar.bz2|*.tar.gz|*.tar.xz)
                                  tar xvf "$n"          ;;
                        *.rar)    unrar -x -ad ./"$n"   ;;
                        *.7z)     7z x ./"$n"           ;;
                        *.zip)     unzip ./"$n"          ;;
                        *)        echo "extract: '$n' - unknown archive method"
                                  return 1
                                  ;;
                        esac
                  else
                      echo "'$n' - file not found"
                      return -1
                  fi
              done
      fi
      }

      # Bindings
      bindkey "^E" history-beginning-search-backward
      bindkey "^N" history-beginning-search-forward
      bindkey "^T" autosuggest-accept

      eval "$(zoxide init --cmd cd zsh)"

      # At shell start command
      # fastfetch -l $(find "$HOME/.config/fastfetch/ascii/" -name "*.txt" | sort -R | head -1)
      fastfetch
    '';

    envExtra = ''
      export SUDO_PROMPT=$'\033[32;05;16m %u\033[0m password -> '
      export TERMINAL="kitty"
      export BROWSER="librewolf"
      export VISUAL="nvim"
      export EDITOR="nvim"
    '';

    antidote = {
      enable = true;
      plugins = [
        "zsh-users/zsh-autosuggestions"
        "zsh-users/zsh-completions"
	"zdharma-continuum/fast-syntax-highlighting"
	"zdharma-continuum/history-search-multi-word"
	"hlissner/zsh-autopair"
	"MichaelAquilina/zsh-you-should-use"
      ];
    };

    shellAliases = let
      flake-dir = "~/nix";
    in {
      boot = "nixos-rebuild boot --use-remote-sudo --flake ${flake-dir}";
      build = "nixos-rebuild dry-build --use-remote-sudo --flake ${flake-dir}";
      switch = "nixos-rebuild switch --use-remote-sudo --flake ${flake-dir}";
      rebuild = "nixos-rebuild test --use-remote-sudo --flake ${flake-dir}";
      update = "nix flake update --flake ${flake-dir}";
      upgrade = "nixos-rebuild test --upgrade --use-remote-sudo --flake ${flake-dir}";
      garbage = "nix-env --delete-generations 7d && nix-store --gc";
      grep="grep --color=auto";
      mkdir = "mkdir -p";
      mv="mv -v";
      rm="rm -vr";
      uz="unzip";
      yz="yazi";
      diff="diff --color";
      stl="steamtinkerlaunch";
      open="xdg-open";
      lgit = "lazygit";
      ll = "eza --color=always --hyperlink -l";
      ls = "eza --color=always --hyperlink";
      cl = "clear";
      tree = "eza --tree --icons --color=always";
      ff = "fastfetch";
      dirh = "dirs -v";
      ".." = "cd ..";
    };

    shellGlobalAliases = {
      "-h"="-h 2>&1 | bat --language=help --style=plain";
      "--help"="--help 2>&1 | bat --language=help --style=plain";
    };

  };

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.eza = {
    enable = true;
    enableZshIntegration = true;
    icons = "always";
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = false;
  };

  programs.bat = {
    enable = true;
  };
}
