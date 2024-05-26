{ inputs, lib, pkgs,  ...}:
{
  programs.home-manager.enable = true;
  home.username = "mon";
  home.homeDirectory = lib.mkDefault "/home/mon";
  home.stateVersion = "23.11";

  imports = 
    [
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
