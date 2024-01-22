{ inputs, pkgs, ...}: 
{
  programs.hyprland = {
  enable  = true;
  package = inputs.hyprland.packages.${pkgs.system}.hyprland;
  };


  environment.systemPackages = with pkgs; [
  obsidian
  alacritty
  firefox
  webcord
  xdg-utils
  # handlr


    
  ]; 

}
