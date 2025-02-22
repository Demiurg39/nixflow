{ ... }: {

  programs.fuzzel = {
    enable = true;
    settings = {
      main = {
        terminal = "kitty -e";
        prompt = "\">>  \"";
        layer = "overlay";
      };
      colors = {
        background = "000000ff";
        text = "e2e2e2ff";
        selection = "242424ff";
        selection-text = "e2e2e2ff";
        border = "242424ff";
        match = "e2e2e2ff";
        selection-match = "e2e2e2ff";
      };
      border = {
        radius = 17;
        width = 2;
      };
      dmenu = { exit-immediately-if-empty = "yes"; };
    };
  };

}
