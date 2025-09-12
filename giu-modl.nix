{ specialArgs, username, lib, pkgs, ... }:

{
  home-manager = {
    inherit specialArgs;
    useGlobalPkgs = true;

    users.${username} = {
      programs.home-manager.enable = true;

      home = {
        username = username;
        homeDirectory = lib.mkDefault "/home/${username}";
        stateVersion = "23.11";
      };

      imports = [
        ../gui/usr/hyprland
      ];
    };
  };
}
