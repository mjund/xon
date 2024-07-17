{pkgs, ...}: { 
 virtualisation.libvirtd.enable = true;
 boot.kernelModules = [ "kvm-amd" "kvm-intel" ];
    users.users.mon = {
     createHome = true;
     isNormalUser = true;
     extraGroups =
       [ "qemu-libvirtd" "libvirtd" 
         "wheel" "video" "audio" "disk" "networkmanager" 
       ]; 
     group = "users";
     home = "/home/mon";
     uid = 1027;
   };
    environment.systemPackages = with pkgs; [

    vagrant
    spice
    spice-gtk
    spice-protocol
    virt-manager
    virt-viewer
    qemu
    OVMF
    glib
    gnome.adwaita-icon-theme
    #virtio-win
    #win-spice
  ];

}
