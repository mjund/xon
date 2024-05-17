{ inputs, system , pkgs,  ...}: 

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

in
  {

    morphero = nixosSystem {
      inherit lib pkgs system;
      specialArgs = { inherit inputs; };
      modules = [
        ./huawei.nix
        ./tty/srvcs
        ./tty/core.nix
        
      ] ++ tiuModule;
    };

    gix = nixosSystem {
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
