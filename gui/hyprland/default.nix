{ inputs, pkgs, ... }: 
{
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    systemd.enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.hyprland;
    plugins = [
      inputs.hyprland-virtual-desktops.packages.${pkgs.system}.virtual-desktops
      # inputs.hycov.packages.${pkgs.system}.hycov
    ];
    # extraConfig = builtins.readFile ./macbook.conf + builtins.readFile ./hyprland.conf +
    extraConfig = with builtins;
      readFile ./binding.conf +
       readFile ./workspaces.conf +
        readFile ./general.conf +
          

     ''
    # virtual desktop
              # stickyrule = class:^(kittysticky)$,3
              # stickyrule = title:thunderbird,mail

              # plugin {
              #     virtual-desktops {
              #         names = 1:coding, 2:internet, 3:mail and chats 
              #         cycleworkspaces = 1
              #         rememberlayout = size
              #         notifyinit = 0
              #         verbose_logging = 0
              #         }
              #       }


    '';


    
  };

  
}
