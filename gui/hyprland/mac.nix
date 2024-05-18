
{...}: {
    wayland.windowManager.hyprland = {
    extraConfig = 
      builtins.readFile ./macbook.conf;

};
}
