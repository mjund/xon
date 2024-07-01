{ pkgs, config, ... }:

{
  imports = [
    <nixpkgs/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix>
    
  ];

  boot.initrd.kernelModules = [ "kvm-intel" ];

  boot.kernelModules = [ "kvm-intel"  "wl" "b43" ];
  boot.extraModulePackages = [ config.boot.kernelPackages.broadcom_sta ];
  # boot.blacklistedKernelModules = [ "wl" ];
        # networking.wireless.enable = false;
        # networking.networkmanager.enable = true;
          environment.systemPackages = with pkgs; [
           helix
          ];
}
