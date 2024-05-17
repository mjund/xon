{ morphero, gix, inputs, system , pkgs,  ...}: 

with inputs;

let 

  inherit (nixpkgs.lib) nixosSystem;
  inherit (pkgs) lib;

  giuModule = [
    home-manager.nixosModules.home-manager
    (import ./giu-modl.nix {
      inherit inputs system;
      extraSpecialArgs = { inherit inputs; };
    })
  ];

  tiuModule = [
    home-manager.nixosModules.home-manager
    (import ./tiu-modl.nix {
      inherit inputs system;
      extraSpecialArgs = { inherit inputs; };
    })
  ];

      inherit morphero gix;

in
  {

    morphero = nixosSystem {
      # systemName = "morphero";
      inherit lib pkgs system;
      specialArgs = { inherit inputs; };
      modules = [
        ./huawei.nix
        ./tty/srvcs
        ./tty/sys/core.nix
        ./gui/sys/gcore.nix
        ./gui/srvcs/greetd.nix
        ./fonts/fonts.nix
        ./gui/hyprland/morhpero.nix
        
      ] ++ tiuModule ++ giuModule;
    };

    gix = nixosSystem {
      # morphero = false;
      # systemName = "gix";
      inherit lib pkgs system;
      specialArgs = { inherit inputs; };
      modules = [
        ./fonts/fonts.nix
        ./tty/sys/core.nix
        ./gui/sys/gcore.nix
        ./gui/srvcs/greetd.nix
        ./tty/srvcs
        ./tty/srvcs/vpns.nix
        ./hardware.nix
        ./gui/hyprland/morhpero.nix
      ] ++ giuModule ++ tiuModule;
    };

    tix = nixosSystem {
      inherit lib pkgs system;
      modules = [
        ./tty/sys/core.nix
        ./tty/srvcs
        ./hardware.nix
      ] ++ tiuModule;
    };

    hix = nixosSystem {
      inherit lib pkgs system;
      specialArgs = { inherit inputs; };
      modules = 
        [
          
        ] ++ tiuModule ++ giuModule;
      
    };

  }
