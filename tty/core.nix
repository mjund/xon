{ inputs,  hostname, username, pkgs, ... }: 

{

  boot = {                                      # Boot Options
  loader = {
    systemd-boot = {
      enable = true;
      configurationLimit = 10;
    };
    efi.canTouchEfiVariables = true;
    # timeout = 4;
    # grub = {
    #   enable = true;
    #   efiSupport = true;
    #   efiInstallAsRemovable = true;
    # };
  };
  };
   
  users.users.${username} = {
    isNormalUser = true;
    extraGroups = ["wheel" "networkmanager" "keyd" "input"];
  };

    systemd.services.keyd = {
    description = "keyd daemon";
    wantedBy = ["sysinit.target"];
    requires = ["local-fs.target"];
    after = ["local-fs.target"];
    serviceConfig = {
      Type = "simple";
      ExecStart = ''${pkgs.keyd}/bin/keyd'';
    };
  };

  
   

  environment.etc = {
    "keyd/default.conf" = {
      text = ''
      
        [ids]

        *

        [main]

        esc = `
        capslock = overload(nav, esc)



        j = overloadt(meta, j, 500)
        f = overloadt(meta, f, 500)
        d = overloadt(control, d, 500)
        k = overloadt(control, k, 500)
        s = overloadt(alt, s, 500)
        l = overloadt(alt, l, 500)
        ; = overloadt(shift, ;, 500)
        a = overloadt(shift, a, 500)
        m = overloadt(meta, m, 500)







        [nav:C]
        j = down
        k = up
        h = left
        l = right
      '';
    };

    "keyd/secKeyboard.conf" = {
      text = ''
      
        [ids]
        2b89:6210

        [main]

        leftmeta = leftalt
        leftalt = leftmeta



        esc = `
        capslock = overload(nav, esc)



        j = overloadt(meta, j, 500)
        f = overloadt(meta, f, 500)
        d = overloadt(control, d, 500)
        k = overloadt(control, k, 500)
        s = overloadt(alt, s, 500)
        l = overloadt(alt, l, 500)
        ; = overloadt(shift, ;, 500)
        a = overloadt(shift, a, 500)
        m = overloadt(meta, m, 500)







        [nav:C]
        j = down
        k = up
        h = left
        l = right
      '';
    };
  };




  security = {
    sudo.enable = false;
    doas.enable = true;
    doas.wheelNeedsPassword = false;
    doas.extraRules = [{
    users = ["${username}"];
    keepEnv = true;  # Optional, retains environment variables while running commands
    noPass = true;
    }];
  };

  
 environment.variables = {
  
};


  console = {
    font = "Lat2-Terminus16";
  };

  environment.systemPackages = with pkgs; [


    wtype
    udisks
    usbutils
    keyd
    duf
    
  ]; 




nix.settings = {

    experimental-features = [ "nix-command" "flakes" ];    builders-use-substitutes = true;

    # substituters to use
    substituters = [
        # "https://anyrun.cachix.org"
        "https://hyprland.cachix.org"
        "https://numtide.cachix.org"
        "https://nix-community.cachix.org"
    ];

    trusted-public-keys = [
        "anyrun.cachix.org-1:pqBobmOjI7nKlsUMV25u9QHa9btJK65/C8vnO3p346s="
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "numtide.cachix.org-1:2ps1kLBUWjxIneOy1Ik6cQjb41X0iXVXeHigGmycPPE="
    ];
};


}
