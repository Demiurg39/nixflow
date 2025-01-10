{ ... }: {

  services.cliphist = {
    enable = true;
    extraOptions = [
      "-max-dedupe-search"
      "20"
      "-max-items"
      "500"
    ];
  };

}
