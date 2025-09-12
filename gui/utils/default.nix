{ lib, pkgs, ...}: 
{

# systemd.user.services.espanso.Service.ExecStart =
#     lib.mkForce "/home/sky/.config/espanso/espanso daemon"; # services.espanso.enable = true;

 # programs.espanso.enable = true;   
  # services.espanso = {
  #   configs = {
  #     default = {
  #       show_notifications = false;
  #     };
  #     kitty = {
  #       filter_class = ".*kitty.*";
  #       paste_shortcut = "CTRL+SHIFT+V";
  #       backend = "Clipboard";
  #       search_shortcut = "off";
  #       enable = false;
  #     };
  #   };
  #   matches = {
  #     fun = {
  #       matches = [
  #         { trigger = ":whoknows:"; replace = "¯\\_(ツ)_/¯"; }
  #         { trigger = ":<3:"; replace = "♡"; }
  #       ];
  #     };
  #     french = {
  #       matches = [
  #         { trigger = "a`"; replace = "à"; }
  #         { trigger = "A`"; replace = "À"; }
  #         { trigger = "a^"; replace = "â"; }
  #         { trigger = "A^"; replace = "Â"; }
  #         { trigger = ".:a"; replace = "ä"; }
  #         { trigger = ".:A"; replace = "Ä"; }
  #         { trigger = "e`"; replace = "è"; }
  #         { trigger = "E`"; replace = "È"; }
  #         { trigger = "e'"; replace = "é"; }
  #         { trigger = "E'"; replace = "É"; }
  #         { trigger = "e^"; replace = "ê"; }
  #         { trigger = "E^"; replace = "Ê"; }
  #         { trigger = "i^"; replace = "î"; }
  #         { trigger = "I^"; replace = "Î"; }
  #         { trigger = "o^"; replace = "ô"; }
  #         { trigger = "O^"; replace = "Ô"; }
  #         { trigger = "u`"; replace = "ù"; }
  #         { trigger = "U`"; replace = "Ù"; }
  #         { trigger = "u^"; replace = "û"; }
  #         { trigger = "U^"; replace = "Û"; }
  #         { trigger = ",c"; replace = "ç"; }
  #         { trigger = ",C"; replace = "Ç"; }
  #         { trigger = "a-e"; replace = "æ"; }
  #         { trigger = "A-E"; replace = "Æ"; }
  #         { trigger = "o-e"; replace = "œ"; }
  #         { trigger = "O-E"; replace = "Œ"; }
  #       ];
  #     };
  #   };
  # };
      
  home.packages = with pkgs; [
    sakura
    grimblast
    # floorp
    telegram-desktop
  ];
}
