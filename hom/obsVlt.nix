
{ config, pkgs, ... }:

let
  myRepo = pkgs.fetchFromGitHub {
    owner = "mjund";
    repo = "obsVlt";
  };
in
{
  home.file."obsVlt".source = myRepo;
}
