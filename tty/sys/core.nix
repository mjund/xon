{ inputs,  pkgs, ... }: 

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

  services = {

    upower.enable = true;
    gvfs.enable = true;
    devmon.enable = true;
    udisks2.enable = true;
    
  };


  # Enable automounting

  # Install necessary packages

  # Configure auto-mount options
  services.udev.extraRules = ''
    ACTION=="add", SUBSYSTEMS=="usb", SUBSYSTEM=="block", ENV{ID_FS_USAGE}=="filesystem", \
      RUN{program}+="${pkgs.udisks}/bin/udisksctl mount -b /dev/%k --no-user-interaction"
  ''; # hardware

  hardware = {
    # pulseaudio = {
    #   enable = true;
    #   package = pkgs.pulseaudioFull;
    # };

    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
  };


  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;
  };


  services.pipewire.wireplumber.extraConfig = {
  "monitor.bluez.properties" = {
      "bluez5.enable-sbc-xq" = true;
      "bluez5.enable-msbc" = true;
      "bluez5.enable-hw-volume" = true;
      "bluez5.roles" = [ "hsp_hs" "hsp_ag" "hfp_hf" "hfp_ag" ];
  };
};


  networking = { 
    hostName = "hix";
    wireless.enable = false;
    networkmanager.enable = true;
    };
  
   
  users.users.mon.isNormalUser = true;
  users.users.mon.extraGroups = ["wheel" "networkmanager" "keyd" "input"];
  

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


    ueberzug
    udisks
    gvfs
    usbutils
    (import ../../pkgs/tmuxifier/default.nix { inherit pkgs lib stdenv fetchFromGitHub; })

    # zellij
    ydotool
    unzip
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
