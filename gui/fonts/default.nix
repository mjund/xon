{ pkgs, ...}: 
{
  home.packages = with pkgs; [
    (nerdfonts.override {fonts = ["IosevkaTerm" "FiraCode" "DroidSansMono" ];})
    (iosevka-bin.override {variant = "slab";})

  ];
}
