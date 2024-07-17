{ inputs, ...}:
{

  imports = [ inputs.nix-flatpak.homeManagerModules.nix-flatpak ];

  services.flatpak.packages = [

    "im.riot.Riot"
    "org.kicad.KiCad"
    "com.logseq.Loqseq"
    
  ];
}
