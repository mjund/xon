{ lib, config, inputs, pkgs, specialArgs,... }: 

  let 
    x = "money";
  in
{
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    systemd.enable = true;
    extraConfig = builtins.readFile ./hyprland.conf;
    
  };

  # home.file."~/.config/hypr/hyprland.conf".text = builtins.readFile ./hyprland.conf;
  
}
