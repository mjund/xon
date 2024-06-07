{ inputs, pkgs, ...}:
{
  imports = [ inputs.ags.homeManagerModules.default ];

  programs.ags = {
    enable = true;

    configDir = ../agss;


    extraPackages = with pkgs; [
      libdbusmenu-gtk3 
      gtksourceview
      webkitgtk
      accountsservice
    ];
    
  };
}
