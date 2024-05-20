{ pkgs, ...}: 

  with pkgs;
  let 
    devel-templ = writeShellScriptBin "dvd" ''

    '';

  in

{
  home.package = [
    devel-templ
  ];
  
}
