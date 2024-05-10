
# make a  derivation for berkeley-mono font installation
{ pkgs ? import <nixpkgs> {} }:

pkgs.stdenv.mkDerivation {
  pname = "kitab-font";
  version = "1.009";

  src = ./.;


# here we install the fonts

  installPhase = ''

    install -Dm644 ./*.ttf -t $out/share/fonts/truetype

  '';
}
