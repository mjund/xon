
{ config, pkgs, ... }:

let
  myRepo = pkgs.fetchFromGitHub {
    owner = "mjund";
    repo = "obsVlt";
    rev = "main";
    sha256 = "sha256-DIMKw/pu48WUxgLovSfU1POHsWgDiWRPtGpssGYy91M=";
  };
in
{
  home.file."obsVlt".source = myRepo;
}
