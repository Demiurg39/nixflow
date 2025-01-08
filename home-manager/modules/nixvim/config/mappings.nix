{ inputs, ... }: let
  inherit (inputs) nixvim;
  inherit (nixvim) mkey;
  inherit (mkey) mkKeymap;
  
  insert = [
    (mkKeymap "i", "<C-b>", "<ESC>^i", "move beginning of line")
    (mkKeymap "i", "<C-e>", "<End>", "move end of line")
    (mkKeymap "i", "<C-h>", "<Left>", "move left")
    (mkKeymap "i", "<C-l>", "<Right>", "move right")
    (mkKeymap "i", "<C-j>", "<Down>", "move down")
    (mkKeymap "i", "<C-k>", "<Up>", "move up")
  ];
  normal = [
  ];
  visual = [
    (mkKeymap "v", "<", "<gv", "indent: increment")
    (mkKeymap "v", ">", ">gv", "indent: decrement")
    (mkKeymap "v", "<A-j>", ":m '>+1<CR>gv=gv", "move line down")
    (mkKeymap "v", "<A-k>", ":m '<-2<CR>gv=gv", "move line up")
  ];

in {
  programs.nixvim.keymaps = insert ++ normal ++ visual
}
