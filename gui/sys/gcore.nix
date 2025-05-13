{ inputs, pkgs, ...}: 
{

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [ libva vaapiVdpau ];
      };

      
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


    gromit-mpx 
    pot
    android-studio

    zathura

    kdePackages.okular
    appimage-run
    immersed
    libreoffice-qt

    pomodoro-gtk
    drawio
    # betterbird
    todoist-electron
    sakura
    st
    # inputs.wezterm.packages.${pkgs.system}.default
    obsidian
    alacritty
    firefox
    webcord
    xdg-utils
    # handlr

    nautilus
    sushi
    # espanso-wayland
    
  ]; 

  services = {
    printing.enable = true;
    avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };
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
