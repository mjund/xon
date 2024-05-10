{ pkgs, ...}: 
{
   
  home.packages = with pkgs; [
    grimblast
    floorp
    telegram-desktop
  ];
}
