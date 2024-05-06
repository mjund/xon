{
  description = "niXon : NixOS & Home Manager configs";


  inputs = {

    nixpkgs.url = "nixpkgs/nixos-unstable";


    devenv.url = "github:cachix/devenv/latest";

    hyprland = {
      url = "github:hyprwm/Hyprland";
      follows = "hyprland-virtual-desktops/hyprland"; # To make sure we run the same version of hyprland that the plugin was built against
    };
    hyprland-virtual-desktops = {
      url = "github:levnikmyskin/hyprland-virtual-desktops";
      # inputs.hyprland.follows = "hyprland";
      };
    
    
    hycov = {
      url = "github:DreamMaoMao/hycov";
      inputs.hyprland.follows = "hyprland";
    };

    hyprfocus = {
      url = "github:VortexCoyote/hyprfocus";
            inputs.hyprland.follows = "hyprland";
    };

    # nixpkgs-nautilus-gtk3.url = github:NixOS/nixpkgs?ref=37bd398;


    anyrun = {
      url = "github:Kirottu/anyrun";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    rycee-nurpkgs = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };


    wezterm.url = "github:wez/wezterm?dir=nix";

    nur.url = "github:nix-community/NUR";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # tmux 

    tmux-sessionx.url = "github:omerxx/tmux-sessionx";

    # neovim-flake = {
    #   #url = git+file:///home/gvolpe/workspace/neovim-flake;
    #   url = github:gvolpe/neovim-flake;
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    # # Fish shell

    # fish-bobthefish-theme = {
    #   url = github:gvolpe/theme-bobthefish;
    #   flake = false;
    # };

    # fish-keytool-completions = {
    #   url = github:ckipp01/keytool-fish-completions;
    #   flake = false;
    # };

    # # Github Markdown ToC generator

    # gh-md-toc = {
    #   url = github:ekalinin/github-markdown-toc;
    #   flake = false;
    # };

    # Nix linter

    # statix = {
    #   url = github:nerdypepper/statix;
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    # Miscelaneous

    # cowsay = {
    #   url = github:snowfallorg/cowsay;
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    # Firefox style
    penguin-fox = {
      url = "github:p3nguin-kun/penguinFox";
      flake = false;
    };

    
  };


  outputs = inputs:
    let
      system = "x86_64-linux";

      pkgs = import inputs.nixpkgs  {
      inherit system;
      config = {
      allowUnfree = true;
      permittedInsecurePackages = [
     "electron-25.9.0"
  ];

};
      };

      extraArgs = inputs;
      specialArgs = {
        inherit system;
        inherit (inputs) hycov penguin-fox;
        inherit (inputs.rycee-nurpkgs.lib.${system}) buildFirefoxXpiAddon;
        addons = pkgs.nur.repos.rycee.firefox-addons;
      };
    in
      {
        nixosConfigurations = 
          import  ./systems.nix { inherit inputs system pkgs extraArgs specialArgs; };
      };
}
