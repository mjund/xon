{...}: {
    wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    systemd.enable = true;
    # package = inputs.hyprland.packages.${pkgs.system}.hyprland;
    plugins = [
      # inputs.hyprland-virtual-desktops.packages.${pkgs.system}.virtual-desktops
      # inputs.hycov.packages.${pkgs.system}.hycov
    ];
    # extraConfig = builtins.readFile ./macbook.conf + builtins.readFile ./hyprland.conf +
    extraConfig = 
      builtins.readFile ./macbook.conf;

};
}
