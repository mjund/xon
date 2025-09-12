{ inputs, pkgs, username, ...}: 
{

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [ libva vaapiVdpau ];
      };

      
  # programs.hyprland = {
  # enable  = true;
  # package = inputs.hyprland.packages.${pkgs.system}.hyprland;
  # };

  
services.greetd = {
  enable = true;
  settings = {
    default_session = {
      command = "${pkgs.hyprland}/bin/Hyprland";
      user = username;
    };
    autologin = false;
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

  

environment.sessionVariables = {
  GTK_THEME = "Adwaita-dark";
  QT_QPA_PLATFORMTHEME = "qt5ct"; # GUI toolkit theme helper
  # GDK_BACKEND = "wayland"; # prefer wayland backend for GTK
  MOZ_ENABLE_WAYLAND = "1"; # Firefox use Wayland
  # XDG_SESSION_TYPE = "wayland"; # hint for session scripts
  XDG_CURRENT_DESKTOP = "GNOME";
};

}
