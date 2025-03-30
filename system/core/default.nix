# default configuration shared by all hosts
{...}: {
  imports = [
    ./security.nix
    ./users.nix
    ../nix
  ];

  i18n = {
    defaultLocale = "en_US.UTF-8";
    supportedLocales = [
      "ru_RU.UTF-8/UTF-8"
      "en_US.UTF-8/UTF-8"
    ];
  };

  # Timezone
  time.timeZone = "Europe/Istanbul";

  zramSwap = {
    enable = true;
    algorithm = "lz4";
    priority = 999;
  };
}
