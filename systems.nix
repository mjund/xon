{ inputs, specialArgs, system , pkgs,  ...}: 

with inputs;

let 

  inherit (nixpkgs.lib) nixosSystem;
  inherit (pkgs) lib;
    # Helper for user-based modules (tiu, xiu, miu, etc.)
  mkUserModule = path: [
    home-manager.nixosModules.home-manager
    (import path {
      inherit inputs system;
      extraSpecialArgs = { inherit inputs; };
    })
  ];

  giuModule = [
    home-manager.nixosModules.home-manager
    (import ./giu-modl.nix {
      inherit inputs system specialArgs;
      extraSpecialArgs = specialArgs // { inherit inputs; };
    })
  ];

  tiuModule = [
    home-manager.nixosModules.home-manager
    (import ./tiu-modl.nix {
      inherit inputs system specialArgs;
      extraSpecialArgs = specialArgs // { inherit inputs; };
    })
  ];
  xiuModule = [
    home-manager.nixosModules.home-manager
    (import ./xiu-modl.nix {
      inherit inputs system specialArgs;
      extraSpecialArgs = specialArgs // { inherit inputs; };
    })
  ];
  miuModule = [
    home-manager.nixosModules.home-manager
    (import ./miu-modl.nix {
      inherit inputs system specialArgs;
      extraSpecialArgs = specialArgs // { inherit inputs; };
    })
  ];
in
  {

    morphero = nixosSystem {
      # systemName = "morphero";
      inherit lib pkgs system;
      specialArgs = specialArgs;
      modules = [
        ./huawei.nix
        ./tty/srvcs
        ./tty/sys/core.nix
        ./gui/sys/gcore.nix
        ./gui/srvcs/greetd.nix
        ./fonts/fonts.nix
        
      ] ++ tiuModule ++ giuModule ++ xiuModule;
    };

    neos = nixosSystem {
      # morphero = false;
      # systemName = "gix";
      inherit lib pkgs system;
      specialArgs = specialArgs;
      modules = [
        ./huawei.nix
        ./tty/core.nix
        ./gui
        # ./hardwares.nix

      ] ++ giuModule ++ tiuModule ++ xiuModule ++ mkUserModule ./tiu-modl.nix;
      
    };

    gix = nixosSystem {
      # morphero = false;
      # systemName = "gix";
      inherit lib pkgs system;
      specialArgs = specialArgs;
      modules = [
        inputs.disko.nixosModules.disko
        # ./espanso
        ./disks/macdisk.nix
        ./fonts/fonts.nix
        ./tty/sys/core.nix
        ./gui/sys/gcore.nix
        ./gui/srvcs/greetd.nix
        ./tty/srvcs
        ./tty/srvcs/vpns.nix
        ./hardware.nix
      ] ++ giuModule ++ tiuModule ++ miuModule;
    };


    livx = nixosSystem {
      inherit lib pkgs system;
      modules = [
        # "${pkgs}/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix"
        ./installer/minimal-mac.nix
        ({pkgs, ...}: {
          networking.networkmanager.enable = true;
          environment.systemPackages = with pkgs; [
           helix 
          ];
        })
      ];
      
    };

    livero = nixosSystem {
      # systemName = "morphero";
      inherit lib pkgs system;
      specialArgs = specialArgs;
      modules = [
        ./installer/live.nix
        # ./huawei.nix
        ./tty/srvcs
        ./tty/sys/core.nix
        ./gui/sys/gcore.nix
        ./gui/srvcs/greetd.nix
        ./fonts/fonts.nix
        
      ] ++ tiuModule ++ giuModule ++ xiuModule;
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
      specialArgs = specialArgs;
      modules = 
        [
          
        ] ++ tiuModule ++ giuModule;
      
    };

  }
