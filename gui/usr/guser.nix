{ inputs, lib, pkgs,  ...}:
{
  programs.home-manager.enable = true;
  home.username = "mon";
  home.homeDirectory = lib.mkDefault "/home/mon";
  home.stateVersion = "23.11";


  home.packages = with pkgs; [
  
    # betterbird
    # todoist-electron
    # sakura
    # # st
    # # inputs.wezterm.packages.${pkgs.system}.default
    # obsidian
    # alacritty
    # firefox
    # webcord
    # xdg-utils
    # # handlr

    # gnome.nautilus
    # gnome.sushi
  ];

  imports = 
    [

      # ../../hom/obsVlt.nix
      ../flatpak
      ../ags
      ../hyprland
      ../editors/vscode.nix
      ../terminals/wezterm.nix
      # ../terminals/alacritty.nix
      ../utils
      # ../browser/firefox.nix
      ../browser/schizofox
      ../browser/chrome.nix
      ../rofi
      ../anyrun
      # ../fonts.nix
    ];
  


}
