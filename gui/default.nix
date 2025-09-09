{ inputs, pkgs, username, ...}: 
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

  
services.greetd = {
  enable = true;
  settings = rec {
    initial_session = {
      command = "${pkgs.hyprland}/bin/Hyprland";
      user = username;
    };
    
      
    autologin = false;
    default_session = initial_session;
  };
};

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [ 
      xdg-desktop-portal-gtk 
      xdg-desktop-portal-hyprland
      ];
    };

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

  
 environment.variables = {
  
};


}
