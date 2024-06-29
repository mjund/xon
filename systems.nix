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
  xiuModule = [
    home-manager.nixosModules.home-manager
    (import ./xiu-modl.nix {
      inherit inputs system;
      extraSpecialArgs = { inherit inputs; };
    })
  ];
  miuModule = [
    home-manager.nixosModules.home-manager
    (import ./miu-modl.nix {
      inherit inputs system;
      extraSpecialArgs = { inherit inputs; };
    })
  ];
in
  {


    livx = nixosSystem {
      inherit lib pkgs system;
      modules = [
        "${pkgs}/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix"
        ./installer/minimal-cam.nix
      ];
      
    };

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
        
      ] ++ tiuModule ++ giuModule ++ xiuModule;
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
      ] ++ giuModule ++ tiuModule ++ miuModule;
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
