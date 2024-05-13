{ inputs , ...}: {
  imports = [ inputs.schizofox.homeManagerModule ];
programs.schizofox = {
  enable = true;

  theme = {
    colors = {
      background-darker = "181825";
      background = "1e1e2e";
      foreground = "cdd6f4";
    };

    font = "Monaspace Krypton";

    extraUserChrome = ''
      body {
        color: red !important;
      }
    '';
  };

  search = {
    defaultSearchEngine = "Searxng";
    removeEngines = ["Google" "Brave" "Bing" "Amazon.com" "eBay" "Wikipedia"];
    searxRandomizer.enable = true;
    # addEngines = [
    #   {
    #     Name = "Etherscan";
    #     Description = "Checking balances";
    #     Alias = "!eth";
    #     Method = "GET";
    #     URLTemplate = "https://etherscan.io/search?f=0&q={searchTerms}";
    #   }
    # ];
  };

  security = {
    sanitizeOnShutdown = false;
    sandbox = true;
    userAgent = "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:106.0) Gecko/20100101 Firefox/106.0";
  };

  misc = {
    drmFix = true;
    disableWebgl = false;
    # firefoxSync = true;
    startPageURL = "https://hn.algolia.com";
  };

  extensions = {
    simplefox.enable = true;
    darkreader.enable = true;

    extraExtensions = let
      mkUrl = name: "https://addons.mozilla.org/firefox/downloads/latest/${name}/latest.xpi";
      extensions = [
        
      ];
      extraExtensions = builtins.foldl' (acc: ext: acc // {ext.id = {install_url = mkUrl ext.name;};}) {} extensions;
    in
      extraExtensions;
      };

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

}
