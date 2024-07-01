{ inputs, pkgs, ...}: 
{
  programs.hyprland = {
  enable  = true;
  # package = inputs.hyprland.packages.${pkgs.system}.hyprland;
  };

  
 environment.variables = {
  
};


  environment.systemPackages = with pkgs; [

    betterbird
    todoist-electron
    sakura
    st
    inputs.wezterm.packages.${pkgs.system}.default
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
