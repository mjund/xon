{pkgs,config,...}: {








    systemd.services.keyd = {
    description = "keyd daemon";
    wantedBy = ["sysinit.target"];
    requires = ["local-fs.target"];
    after = ["local-fs.target"];
    serviceConfig = {
      Type = "simple";
      ExecStart = ''${pkgs.keyd}/bin/keyd'';
    };
  };

  
   

  environment.etc = {

    # ".config/keyd/app.conf" = {
    #   source = config.lib.file.mkOutOfStoreSymlink ./app.conf; 
    # };
    "keyd/default.conf" = {
      source = ./default.conf; 
    };


  };

}


