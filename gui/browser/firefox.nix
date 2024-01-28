{ inputs, config, pkgs, lib, specialArgs, ... }:

let
  system = "x86_64-linux";
  inherit (inputs) penguin-fox;
  inherit (inputs.rycee-nurpkgs.lib.${system}) buildFirefoxXpiAddon;

  nur-no-pkgs = import (builtins.fetchTarball {
    
  url = "https://github.com/nix-community/NUR/archive/master.tar.gz";
  sha256 = "sha256:01qkhk3abc6wbljh5bdgfs6bh8bdy92k9j4njxpi09m4vycpplsl";

  }) { inherit pkgs; };

  addons = nur-no-pkgs.repos.rycee.firefox-addons;

  customAddons = pkgs.callPackage ./firefox-addons.nix {
    inherit lib;
    inherit buildFirefoxXpiAddon;
  };

  extensions = with addons;[

    surfingkeys

    onetab
    

    

    darkreader

    bitwarden
    ff2mpv

    
    # auto-accepts cookies, use only with privacy-badger & ublock-origin
    i-dont-care-about-cookies
    languagetool
    link-cleaner
    privacy-badger
    to-deepl
    ublock-origin
    unpaywall

    # ];
  ] ++ (with customAddons; [ chatgpt ]);

  # disable the annoying floating icon with camera and mic when on a call
  disableWebRtcIndicator = ''
    #webrtcIndicator {
      display: none;
    }
  '';

  userChrome = disableWebRtcIndicator;


  # ~/.mozilla/firefox/PROFILE_NAME/prefs.js | user.js
  settings = {

    # apperance 
    "browser.in-content.dark-mode" = true;
    "ui.systemUsesDarkTheme" = true; # Dark mode


    # general

    "browser.newtabpage.activity-stream.section.highlights.includePocket" = false; # Disable pocket
    "extensions.pocket.enabled" = false; # Disable pocket

    "app.normandy.first_run" = false;
    "app.shield.optoutstudies.enabled" = false;


    # disable updates (pretty pointless with nix)
    "app.update.channel" = "default";

    "browser.contentblocking.category" = "standard"; # "strict"
    "browser.ctrlTab.recentlyUsedOrder" = false;

    "browser.download.useDownloadDir" = false;
    "browser.download.viewableInternally.typeWasRegistered.svg" = true;
    "browser.download.viewableInternally.typeWasRegistered.webp" = true;
    "browser.download.viewableInternally.typeWasRegistered.xml" = true;

    "browser.link.open_newwindow" = true;

    "browser.search.region" = "PL";
    "browser.search.widget.inNavBar" = true;

    "browser.shell.checkDefaultBrowser" = false;
    "browser.startup.homepage" = "https://nixos.org";
    "browser.tabs.loadInBackground" = true;
    "browser.urlbar.placeholderName" = "DuckDuckGo";
    "browser.urlbar.showSearchSuggestionsFirst" = false;

    # disable all the annoying quick actions
    "browser.urlbar.quickactions.enabled" = false;
    "browser.urlbar.quickactions.showPrefs" = false;
    "browser.urlbar.shortcuts.quickactions" = false;
    "browser.urlbar.suggest.quickactions" = false;

    "distribution.searchplugins.defaultLocale" = "en-US";

    "doh-rollout.balrog-migration-done" = true;
    "doh-rollout.doneFirstRun" = true;

    "dom.forms.autocomplete.formautofill" = false;

    "general.autoScroll" = true;
    "general.useragent.locale" = "en-US";

    "extensions.activeThemeID" = "dark@mozilla.org";

    "extensions.extensions.activeThemeID" = "dark@mozilla.org";
    "extensions.update.enabled" = false;
    "extensions.webcompat.enable_picture_in_picture_overrides" = true;
    "extensions.webcompat.enable_shims" = true;
    "extensions.webcompat.perform_injections" = true;
    "extensions.webcompat.perform_ua_overrides" = true;

    "print.print_footerleft" = "";
    "print.print_footerright" = "";
    "print.print_headerleft" = "";
    "print.print_headerright" = "";

    "privacy.donottrackheader.enabled" = true;

    # Yubikey
    "security.webauth.u2f" = true;
    "security.webauth.webauthn" = true;
    "security.webauth.webauthn_enable_softtoken" = true;
    "security.webauth.webauthn_enable_usbtoken" = true;

    "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
  };

  demoSettings = {
    "accessibility.force_disabled" = 1;
    # disable Studies
    # disable Normandy/Shield [FF60+]
    # Shield is a telemetry system that can push and test "recipes"
    "app.normandy.api_url" = "";
    "app.normandy.enabled" = false;

    "browser.aboutConfig.showWarning" = false;

    # personalized Extension Recommendations in about:addons and AMO [FF65+]
    # https://support.mozilla.org/kb/personalized-extension-recommendations 
    "browser.discovery.enabled" = false;
    "browser.helperApps.deleteTempFileOnExit" = true;

    "browser.newtabpage.activity-stream.default.sites" = "";
    "browser.newtabpage.activity-stream.feeds.topsites" = false;
    "browser.newtabpage.activity-stream.showSponsored" = false;
    "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
    "browser.uitour.enabled" = false;

    # use Mozilla geolocation service instead of Google.
    #"geo.provider.network.url"= "https://location.services.mozilla.com/v1/geolocate?key=%MOZILLA_API_KEY%";
    # disable using the OS's geolocation service
    "geo.provider.use_gpsd" = false;
    "geo.provider.use_geoclue" = false;

    # HIDDEN PREF: disable recommendation pane in about:addons (uses Google Analytics)
    "extensions.getAddons.showPane" = false;
    # recommendations in about:addons' Extensions and Themes panes [FF68+]
    "extensions.htmlaboutaddons.recommendations.enabled" = false;

    # disable Network Connectivity checks
    # [1] https://bugzilla.mozilla.org/1460537
    "network.connectivity-service.enabled" = false;

    # integrated calculator
    "browser.urlbar.suggest.calculator" = true;

    # TELEMETRY

    # disable new data submission
    "datareporting.policy.dataSubmissionEnabled" = false;
    # disable Health Reports
    "datareporting.healthreport.uploadEnabled" = false;
    # 0332: disable telemetry
    "toolkit.telemetry.unified" = false;
    "toolkit.telemetry.enabled" = false;
    "toolkit.telemetry.server" = "data:,";
    "toolkit.telemetry.archive.enabled" = false;
    "toolkit.telemetry.newProfilePing.enabled" = false;
    "toolkit.telemetry.shutdownPingSender.enabled" = false;
    "toolkit.telemetry.updatePing.enabled" = false;
    "toolkit.telemetry.bhrPing.enabled" = false;
    "toolkit.telemetry.firstShutdownPing.enabled" = false;
    # disable Telemetry Coverage
    "toolkit.telemetry.coverage.opt-out" = true; # [HIDDEN PREF]
    "toolkit.coverage.opt-out" = true; # [FF64+] [HIDDEN PREF]
    "toolkit.coverage.endpoint.base" = "";
    # disable PingCentre telemetry (used in several System Add-ons) [FF57+]
    "browser.ping-centre.telemetry" = false;
    # disable Firefox Home (Activity Stream) telemetry
    "browser.newtabpage.activity-stream.feeds.telemetry" = false;
    "browser.newtabpage.activity-stream.telemetry" = false;
    "toolkit.telemetry.reportingpolicy.firstRun" = false;
    "toolkit.telemetry.shutdownPingSender.enabledFirstsession" = false;
    "browser.vpn_promo.enabled" = false;
  } // settings;
    ExtensionSettings = with builtins;
        let extension = shortId: uuid: {
          name = uuid;
          value = {
            install_url = "https://addons.mozilla.org/en-US/firefox/downloads/latest/${shortId}/latest.xpi";
            installation_mode = "normal_installed";
          };
        };
        in listToAttrs [
          (extension "tree-style-tab" "treestyletab@piro.sakura.ne.jp")
          (extension "ublock-origin" "uBlock0@raymondhill.net")
          (extension "bitwarden-password-manager" "{446900e4-71c2-419f-a6a7-df9c091e268b}")
          (extension "tabliss" "extension@tabliss.io")
          (extension "umatrix" "uMatrix@raymondhill.net")
          (extension "libredirect" "7esoorv3@alefvanoon.anonaddy.me")
          (extension "clearurls" "{74145f27-f039-47ce-a470-a662b129930a}")
        ];
in
{
  programs.firefox = {
    enable = true;

    package = pkgs.firefox-beta-bin;

    policies = {
      inherit ExtensionSettings;
    };

    profiles = {
      default = {
        id = 0;
        inherit extensions settings;
        userChrome = lib.readFile "${penguin-fox}/files/chrome/userChrome.css";
        userContent = lib.readFile "${penguin-fox}/files/chrome/userContent.css";

      };

      chatroulette = {
        id = 1;
        inherit extensions settings userChrome;
      };

      demo = {
        id = 2;
        inherit extensions;
        settings = demoSettings;
        userChrome = lib.readFile "${penguin-fox}/files/chrome/userChrome.css";
        userContent = lib.readFile "${penguin-fox}/files/chrome/userContent.css";
      };

      sxm = {
        id = 3;
        inherit extensions settings userChrome;
      };
    };
  };
}
