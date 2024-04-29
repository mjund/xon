{ buildFirefoxXpiAddon, lib }:

{
  chatgpt = buildFirefoxXpiAddon rec {
    pname = "chatgpt_for_search_engines";
    version = "1.5.4";
    addonId = "{28c31a34-6fa8-4962-91eb-2f4777de6e68}";
    url = "https://addons.mozilla.org/firefox/downloads/file/4055458/${pname}-${version}.xpi";
    sha256 = "sha256-CDfYJN7le+F4cXWi2mK3RhhGYGzUzFX5vsHiz6Y5m+g=";
    meta = with lib;
      {
        homepage = "https://chatonai.org/";
        description = "ChatGPT for search engines";
        license = licenses.mpl20;
        platforms = platforms.all;
      };
  };

 https = buildFirefoxXpiAddon rec {
              pname = "clean-up";
          version = "0.1.0";
          addonId = "{a1087d5d-d793-445a-b988-088b1d86f2a6}";
          url = "https://addons.mozilla.org/firefox/downloads/file/3610512/bookmarks_clean_up-${version}.xpi";
          sha256 = "sha256-4FNojXUkm+8lFEBbQOfpdlZgt/SfB8AAGCOiGyWnsuo=";
          meta = { };  };
}

