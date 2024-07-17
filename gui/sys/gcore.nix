{ inputs, pkgs, ...}: 
{
  programs.hyprland = {
  enable  = true;
  # package = inputs.hyprland.packages.${pkgs.system}.hyprland;
  };


  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    };

  
 environment.variables = {
  
};


  environment.systemPackages = with pkgs; [

    drawio
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
    # espanso-wayland
    
  ]; 

  services = {
    # espanso.enable = true;
    # espanso.wayland = true;
    # espanso.package = mkIf (cfg.wayland or false) pkgs.espanso-wayland;
    dbus.enable = true;
    flatpak.enable = true;
    gvfs = {
      enable = true;
      package = pkgs.gnome.gvfs;
    };
  };

}
