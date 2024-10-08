{pkgs, ...}: { 
 virtualisation = {
  libvirtd.enable = true;
  docker.enable = true;
  waydroid.enable = true;

  };
 boot.kernelModules = [ "kvm-amd" "kvm-intel" ];
    users.users.mon = {
     createHome = true;
     isNormalUser = true;
     extraGroups =
       [ "qemu-libvirtd" "libvirtd" "docker"
         "wheel" "video" "audio" "disk" "networkmanager" 
       ]; 
     group = "users";
     home = "/home/mon";
     uid = 1027;
   };
    environment.systemPackages = with pkgs; [

    docker-compose
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
