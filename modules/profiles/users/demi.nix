{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  username = config.modules.profiles.user;
in
  mkIf (username == "demi") {
    user = {
      name = username;
      hashedPasswordFile = config.age.secrets.demi_pass.path;
      shell = pkgs.nushell;
    };

    i18n = {
      defaultLocale = mkDefault "en_US.UTF-8";
      supportedLocales = [
        "ru_RU.UTF-8/UTF-8"
        "en_US.UTF-8/UTF-8"
      ];
    };
    console.keyMap = "mod-dh-ansi-us";
  }
