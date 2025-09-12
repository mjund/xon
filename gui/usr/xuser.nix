{ inputs, username, lib, pkgs,  ...}:
{
  programs.home-manager.enable = true;
  home.username = username;
  home.homeDirectory = lib.mkDefault "/home/mon";
  home.stateVersion = "23.11";

  imports = 
    [
      ../hyprland/morphero.nix
    ];
  


}
