{pkgs, ...}: {
  programs.vscode = {
  enable = true;
  package = pkgs.vscodium;
  profiles.default.extensions = with pkgs.vscode-extensions; [
    dracula-theme.theme-dracula
    yzhang.markdown-all-in-one

  ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
    {
      name = "vscode-helix-emulation";
      publisher = "jasew";
      version = "0.4.1";
      sha256 = "sha256-t2vOHCZUS0RI1HajbhylNCEScS4RHstUDTYny2rU8xE=";
      
    }
    {
      name = "copilot";
      publisher = "GitHub";
      version = "1.146.639";
      sha256 = "sha256-ss67kcIH1p0jxUBfcPds6AkNpgQ7n1Mww4bSQaD6NQw=";
      
    }
  {
      name = "cody-ai";
      publisher = "sourcegraph";
      version = "1.1.1704757047";
      sha256 = "sha256-MTVxZ6puoRWIEcKulpCCTC8M4xwg74AHvTS3CYxmXsw=";
      
    }
    ];
};

}
