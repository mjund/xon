{ inputs, username, lib, pkgs,  ...}:
{
  programs.home-manager.enable = true;
  home.username = username;
  home.homeDirectory = lib.mkDefault "/home/${username}";
  home.stateVersion = "23.11";

  imports = 
    [

      ../hyprland
      # ../esp
      # ../../hom/obsVlt.nix
      # ../flatpak
      # ../ags
      # ../editors/vscode.nix
      # ../terminals/wezterm.nix
      # ../terminals/alacritty.nix
      ../utils
      # ../browser/firefox.nix
      # ../browser/schizofox
      ../browser/chrome.nix
      # ../rofi
      ../anyrun
      # ../fonts.nix
    ];
  


}
