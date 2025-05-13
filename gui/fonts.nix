{ pkgs, ...}: 
{
  home.packages = with pkgs.nerd-fonts; [
    # (nerdfonts.override {fonts = ["IosevkaTerm" "FiraCode" "DroidSansMono" ];})
    # (iosevka-bin.override {variant = "slab";})

    IsovekaTerm
    FiraCode
    DroidSansMono

  ];
}

