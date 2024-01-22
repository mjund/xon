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

  gnome.nautilus
  gnome.sushi
    
  ]; 

  services = {
    gvfs = {
      enable = true;
      package = pkgs.gnome.gvfs;
    };
  };

}
