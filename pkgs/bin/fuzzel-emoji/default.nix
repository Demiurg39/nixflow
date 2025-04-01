{pkgs, ...}:
pkgs.writeShellScriptBin "fuzzel-emoji" ''
  #!${pkgs.bash}/bin/bash
  if [ $? -eq 0 ]
  then
      sed '1,/^### DATA ###$/d' $0 | fuzzel --match-mode fzf --dmenu | cut -d ' ' -f 1 | tr -d '\n' | wl-copy
  else
      sed '1,/^### DATA ###$/d' $0 | fuzzel --match-mode fzf --dmenu | cut -d ' ' -f 1 | tr -d '\n' | wl-copy
  fi
  exit
''
++ builtins.readFile ./data
