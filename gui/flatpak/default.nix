{ inputs, ...}:
{

  imports = [ inputs.flatpaks.homeManagerModules.nix-flatpak ];

  services.flatpak.packages = [

    "im.riot.Riot"
    "com.logseq.Loqseq"
    
  ];
}
