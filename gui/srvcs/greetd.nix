{ pkgs, ...}: {
  
services.greetd = {
  enable = true;
  settings = rec {
    initial_session = {
      command = "${pkgs.hyprland}/bin/Hyprland";
      user = "mon";
    };
    
      
    autologin = false;
    default_session = initial_session;
  };
};

}
