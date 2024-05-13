{  pkgs, ... }: 

{

  boot = {                                      # Boot Options
  loader = {
    systemd-boot = {
      enable = true;
      configurationLimit = 10;
    };
    efi.canTouchEfiVariables = true;
    timeout = 4;
  };
  };


  # hardware

  hardware = {
    pulseaudio = {
      enable = true;
      package = pkgs.pulseaudioFull;
    };

    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
  };

  networking = { 
    hostName = "hix";
    networkmanager.enable = true;
    };
  
   
  users.users.mon.isNormalUser = true;
  users.users.mon.extraGroups = ["wheel" "networkmanager" "keyd"];
  

 environment.variables = {
  
};

environment.sessionVariables = {
  
};

  security = {
    sudo.enable = false;
    doas.enable = true;
    doas.wheelNeedsPassword = false;
    doas.extraRules = [{
    users = ["mon"];
    keepEnv = true;  # Optional, retains environment variables while running commands
    noPass = true;
    }];
  };

  console = {
    
  };

  environment.systemPackages = with pkgs; [

    unzip
    tmux
    helix
    git
    nil
    keyd
    wl-clipboard
    duf
    fx
    glow
    tldr
    
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
