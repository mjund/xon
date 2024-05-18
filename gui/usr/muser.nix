{ inputs, lib, pkgs,  ...}:
{
  programs.home-manager.enable = true;
  home.username = "mon";
  home.homeDirectory = lib.mkDefault "/home/mon";
  home.stateVersion = "23.11";

  imports = 
    [
      ../hyprland/mac.nix
    ];
  


}
