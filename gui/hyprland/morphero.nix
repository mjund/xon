{...}: {
    wayland.windowManager.hyprland = {
    extraConfig = 
      builtins.readFile ./huawei.conf;

};
}
