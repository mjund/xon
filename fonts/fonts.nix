{pkgs,...}: 

let 
  kitab-font = pkgs.callPackage ./kitab-fonts { inherit pkgs; };
in
{
  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
    kitab-font
    ubuntu_font_family
    vazir-fonts
    monaspace
    (nerdfonts.override {fonts = ["IosevkaTerm" "FiraCode" "DroidSansMono" ];})
    # (iosevka-bin.override {variant = "slab";})
    ];

    fontconfig = {
      defaultFonts = {
        serif = [ "Vazirmatn" "Ubuntu" ];
        sansSerif = [ "Vazirmatn" "Ubuntu "];
        monospace = [ "Monaspace Krypton"];
      };
    };
  };
}
