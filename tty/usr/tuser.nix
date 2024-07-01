{  lib,  ...}:
{
  programs.home-manager.enable = true;
  home.username = "mon";
  home.homeDirectory = lib.mkDefault "/home/mon";
  home.stateVersion = "23.11";

  imports = 
    [
      ../zellij
      ../../hom/bin
      # ../../hom/fns
      ../tmux/tmuxifier.nix
      ../tmux
      ../shell
      ../utils
      ../editors
      ../git
    ];


}
