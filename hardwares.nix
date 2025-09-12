{ pkgs}:
{
  
  networking = { 
    hostName = "hix";
    wireless.enable = false;
    networkmanager.enable = true;
    };

#   hardware = {
#     bluetooth = {
#       enable = true;
#       powerOnBoot = true;
#     };
#   };
#   services = {
#     upower.enable = true;
#     devmon.enable = true;
#     udisks2.enable = true;
#  };


#   # Enable automounting

#   # Install necessary packages

#   # Configure auto-mount options
#   services.udev.extraRules = ''
#     ACTION=="add", SUBSYSTEMS=="usb", SUBSYSTEM=="block", ENV{ID_FS_USAGE}=="filesystem", \
#       RUN{program}+="${pkgs.udisks}/bin/udisksctl mount -b /dev/%k --no-user-interaction"
#   ''; # hardware


#   security.rtkit.enable = true;
#   services.pipewire = {
#     enable = true;
#     alsa.enable = true;
#     alsa.support32Bit = true;
#     pulse.enable = true;
#     # If you want to use JACK applications, uncomment this
#     #jack.enable = true;
#   };


#   services.pipewire.wireplumber.extraConfig = {
#   "monitor.bluez.properties" = {
#       "bluez5.enable-sbc-xq" = true;
#       "bluez5.enable-msbc" = true;
#       "bluez5.enable-hw-volume" = true;
#       "bluez5.roles" = [ "hsp_hs" "hsp_ag" "hfp_hf" "hfp_ag" ];
#   };
# };


  

}
