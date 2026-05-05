{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  cfg = config.modules.desktop.browser.qutebrowser;
  bCfg = config.modules.desktop.browser;

  name = "qutebrowser";

  def_url = "https://4get.ca";
  start_page = def_url;

  # NOTE: in case of adding new dict, you must yourself browse the url
  # and fill the hash and version per lang, per update sure do
  # the same thing
  languages = config.home.programs.qutebrowser.settings.spellcheck.languages;
  dictsURL = "https://chromium.googlesource.com/chromium/deps/hunspell_dictionaries.git/+/refs/heads/main";
  dictVersions = {
    "en-US" = {
      v = "10-1";
      hash = "1bxn778sqd6q144hr4d6l18s34n1mjc6bp6dsjlp2sbhw4kh38h1";
    };
    "ru-RU" = {
      v = "3-0";
      hash = "1qv04065g6mxshz6s42y6b69cwscvdmbi2ji5mqc9s79pwi9xy4c";
    };
  };
in {
  options.modules.desktop.browser.qutebrowser = {
    enable = mkEnableOption "Enable qutebrowser";
    setDefault = mkOpt types.bool false;
    widevine.enable = mkEnableOption ''
      Widevine is a proprietary digital rights management (DRM) technology
      from Google used by many web browsers. Widevine is required to watch
      content on many subscription-based streaming services,
      e.g. Netflix,Prime Video, Spotify, etc.
    '';
  };

  config = mkIf (cfg.enable) {
    modules.desktop.browser.default =
      if cfg.setDefault
      then name
      else "";
    modules.desktop.browser.spawnCmd =
      if bCfg.default == name
      then "qutebrowser"
      else "";
    fonts.packages = [pkgs.inter];

    home.programs.qutebrowser = {
      enable = true;
      package = pkgs.qutebrowser.override {enableWideVine = cfg.widevine.enable;};
      settings = {
        auto_save.session = true;
        backend = "webengine";
        colors.webpage.darkmode = {
          algorithm = "lightness-cielab";
          enabled = true;
          policy.images = "smart-simple";
          policy.page = "smart";
        };
        colors.webpage.preferred_color_scheme = "light";
        completion.height = "40%";
        content.autoplay = false;
        content.blocking.enabled = true;
        content.blocking.method = "adblock";
        content.cache.size = 52428800; # 50mibs
        content.canvas_reading = false;
        content.cookies.accept = "all"; # Might break some sites such as Gmail
        content.cookies.store = true;
        content.default_encoding = "utf-8";
        content.geolocation = false;
        content.headers.do_not_track = true;
        content.pdfjs = true;
        content.webgl = false;
        content.webrtc_ip_handling_policy = "default-public-interface-only";
        downloads.remove_finished = 3000;
        fonts.default_family = "Inter";
        fonts.default_size = "11pt";
        hints.chars = "arstgmneio";
        qt.args = ["process-per-site" "enable-gpu-rasterization"];
        session.default_name = "default";
        session.lazy_restore = true;
        spellcheck.languages = ["en-US" "ru-RU"];
        tabs.indicator.width = 0; # no tab indicators
        tabs.mousewheel_switching = false;
        tabs.show = "multiple";
        url.default_page = def_url;
        url.start_pages = start_page;
        window.hide_decoration = true;
        window.transparent = true;
      };
      perDomainSettings = {
        "file://*" = {colors.webpage.darkmode.enabled = false;};
      };
      searchEngines = {
        DEFAULT = "${def_url}/web?s={}";
        "!vid" = "${def_url}/videos?s={}";
        "!img" = "${def_url}/images?s={}";
        "!yt" = "https://youtube.com/results?search_query={}";
        "!gh" = "https://github.com/search?q={}";
        "!pkgs" = "https://search.nixos.org/packages?query={}";
        "!opts" = "https://search.xn--nschtos-n2a.de/?query={}";
        "!nw" = "https://wiki.nixos.org/w/index.php?search={}";
        "!nwu" = "https://nixos.wiki/index.php?search={}";
        "!nf" = "https://noogle.dev/q?term={}";
        "!ddg" = "https://duckduckgo.com/?q={}";
        "!tl" = "https://www.reverso.net/text-translation#sl=rus&tl=eng&text={}";
      };
      greasemonkey = [];
      keyBindings = {
        normal = {
          ",d" = "config-cycle colors.webpage.darkmode.enabled true false";
        };
      };
    };

    # Installing spellcheck dicts
    home.file = listToAttrs (map (
        lang: let
          dict = dictVersions.${lang};
          fn = "${lang}-${dict.v}.bdic";
          base64File = pkgs.fetchurl {
            url = "${dictsURL}/${fn}?format=TEXT";
            sha256 = dict.hash;
          };
          dictFile =
            pkgs.runCommand fn {
              nativeBuildInputs = [pkgs.coreutils];
            } ''
              base64 -d < ${base64File} > $out
            '';
        in {
          name = ".local/share/qutebrowser/qtwebengine_dictionaries/${fn}";
          value.source = dictFile;
        }
      )
      languages);
  };
}
