{ lib, config, inputs, pkgs, specialArgs,... }: 

  let 
    x = "money";
  in
{
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    systemd.enable = true;
    plugins = [
      inputs.hycov.packages.${pkgs.system}.hycov
      # inputs.virtual-desktops.packages.${pkgs.system}.default
      # inputs.hyprfocus.packages.${pkgs.system}.default
    ];
    extraConfig = builtins.readFile ./hyprland.conf +

     ''
    # hycov config

     plugin {
         hycov {
           overview_gappo = 60 #gaps width from screen
           overview_gappi = 24 #gaps width from clients
     	    hotarea_size = 10 #hotarea size in bottom left,10x10
     	    enable_hotarea = 1 # enable mouse cursor hotarea
         }
     }

     bind=ALT,tab,hycov:toggleoverview
     bind=ALT,left,hycov:movefocus,l
     bind=ALT,right,hycov:movefocus,r
     bind=ALT,up,hycov:movefocus,u
     bind=ALT,down,hycov:movefocus,d


    '';


    
  };

  # home.file."~/.config/hypr/hyprland.conf".text = builtins.readFile ./hyprland.conf;
  
}
