{ inputs, pkgs, ...}:
let
  arcwtf = pkgs.fetchFromGitHub {
    owner = "kikaraage";
    repo = "arcwtf";
    rev = "bb6f2b7ef7e3d201e23d86bf8636e5d0ea4bd68b";
    hash = "sha256-gyJiIVnyZOYVX6G3m4SSbsb7K9g4zKZWlrHphEIQwsY=";
  };
  catppuccin-tridactyl = pkgs.fetchFromGitHub {
    "owner" = "lonepie";
    "repo" = "catppuccin-tridactyl";
    "rev" = "a77c65f7ab5946b37361ae935d2192a9a714f960";
    "hash" = "sha256-LjLMq7vUwDdxgpdP9ClRae+gN11IPc+XMsx8/+bwUy4=";
  };
in {

  xdg = {
    configFile = {
      # "tridactyl/tridactylrc".source = ./tridactylrc;
      "tridactyl/themes/catppuccin.css".source =
        catppuccin-tridactyl + "/catppuccin.css";
    };

  };

    home.file = {
    ".mozilla/firefox/schizo.default/chrome/content/".source = arcwtf + "/content";
    ".mozilla/firefox/schizo.default/chrome/global/".source = arcwtf + "/global";
    ".mozilla/firefox/schizo.default/chrome/icons/".source = arcwtf + "/icons";
    ".mozilla/firefox/schizo.default/chrome/toolbar/".source = arcwtf + "/toolbar";
    ".mozilla/firefox/schizo.default/chrome/tweaks/".source = arcwtf + "/tweaks";
    ".mozilla/native-messaging-hosts/com.ugetdm.firefox.json".source = "${pkgs.uget-integrator}/lib/mozilla/native-messaging-hosts/com.ugetdm.firefox.json";
    ".mozilla/native-messaging-hosts/tridactyl.json".source = "${pkgs.tridactyl-native}/lib/mozilla/native-messaging-hosts/tridactyl.json";
  };

imports = [ inputs.schizofox.homeManagerModule ];
programs.schizofox = {
  enable = true;

  theme = {

    font = "Monaspace Krypton";

    defaultUserChrome.enable = false;
    defaultUserContent.enable = true;


    extraUserChrome = ''
            /* ArcWTF main files */
        @import url("icons/icons.css");
        @import url("toolbar/tabbar.css");
        @import url("toolbar/navbar.css");
        @import url("toolbar/personalbar.css");
        @import url("toolbar/findbar.css");
        @import url("toolbar/urlbar.css");
        @import url("global/colors.css");
        @import url("global/popup.css");
        @import url("global/browser.css");
        @import url("global/tree.css");

        /* Tweaks */
        @import url("global/tweaks.css");
        @import url("tweaks/hide-tabs-bar.css");
        @import url("tweaks/extensions.css");
        /* @import url("tweaks/sidebar.css"); */
        @import url("tweaks/popup-search.css");

        /* Replacing Userchrome Toggle icon with Arc sidebar icon */
        :is(.webextension-browser-action, .eom-addon-button)[data-extensionid="userchrome-toggle@joolee.nl"] .toolbarbutton-icon { list-style-image: url(./icons/userchrome-toggle.svg); }

        * {font-family: "Poppins" !important;}

        /* Disable tab bar when sidebery is active. the titlepreface is non width space. */
        #main-window[titlepreface*="​"] #TabsToolbar {
          visibility: collapse !important;
        }

        /* hide sidebar header */
        #sidebar-header {
          visibility: collapse !important;
        }


    '';
  };

  search = {
    defaultSearchEngine = "Searxng";
    removeEngines = ["DuckDuckGo" "Google" "Brave" "Bing" "Amazon.com" "eBay" "Wikipedia"];
    searxRandomizer.enable = true;
    addEngines = [
      {
        Name = "Searxng";
        Description = "DeSearchEngine";
        Alias = "sx";
        Method = "GET";
        URLTemplate = "https://searx.be/search?q={searchTerms}&categories=general";
      }
    #   {
    #     Name = "Etherscan";
    #     Description = "Checking balances";
    #     Alias = "!eth";
    #     Method = "GET";
    #     URLTemplate = "https://etherscan.io/search?f=0&q={searchTerms}";
    #   }
    ];
  };

  security = {
    sanitizeOnShutdown = false;
    sandbox = true;
    userAgent = "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:106.0) Gecko/20100101 Firefox/106.0";
  };

  misc = {
    drm.enable = true;
    disableWebgl = false;
    # firefoxSync = true;
    startPageURL = "https://hn.algolia.com";
    bookmarks = [
      {
        Title = "Example";
        URL = "https://example.com";
        Favicon = "https://example.com/favicon.ico";
        Placement = "toolbar";
        Folder = "FolderName";
      }
    ];
  };

  extensions = {
    simplefox.enable = true;
    darkreader.enable = true;

    extraExtensions = let
      mkUrl = name: "https://addons.mozilla.org/firefox/downloads/latest/${name}/latest.xpi";
      extensions = [

                  {
              id = "1018e4d6-728f-4b20-ad56-37578a4de76";
              name = "flagfox";
            }
            {
              id = "{c2c003ee-bd69-42a2-b0e9-6f34222cb046}";
              name = "auto-tab-discard";
            }
            {
              id = "{a4c4eda4-fb84-4a84-b4a1-f7c1cbf2a1ad}";
              name = "refined-github-";
            }
            {
              id = "sponsorBlocker@ajay.app";
              name = "sponsorblock";
            }
            {
              id = "{446900e4-71c2-419f-a6a7-df9c091e268b}";
              name = "bitwarden-password-manager";
            }
        
      ];
      extraExtensions = builtins.foldl' (acc: ext: acc // {ext.id = {install_url = mkUrl ext.name;};}) {} extensions;
    in
      extraExtensions;
      };


};

}
