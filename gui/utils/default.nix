{ pkgs, ...}: 
{
   
  home.packages = with pkgs; [
    floorp
    telegram-desktop
  ];
}
