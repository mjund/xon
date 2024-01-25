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


  networking = { 
    hostName = "hix";
    networkmanager.enable = true;
    };
  
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

   
  users.users.mon.isNormalUser = true;
  users.users.mon.extraGroups = ["wheel" "networkmanager" "keyd"];
  


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
    builders-use-substitutes = true;
    # substituters to use
    substituters = [
        "https://anyrun.cachix.org"
    ];

    trusted-public-keys = [
        "anyrun.cachix.org-1:pqBobmOjI7nKlsUMV25u9QHa9btJK65/C8vnO3p346s="
    ];
};
}
