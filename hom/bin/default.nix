{ pkgs, ...}: 

  with pkgs;
  let 
    disable-wake = writeShellScriptBin "diswake" ''
    echo 'disabled' > '/sys/bus/usb/devices/3-1.4/power/wakeup';
    echo 'disabled' > '/sys/bus/usb/devices/2-1.8.2/power/wakeup';

    '';
    devel-templ = writeShellScriptBin "dvd" ''

    '';

    git-push = writeShellScriptBin "push" ''
          if [ -z "$1" ]; then
            echo "Error: No commit message provided."
            echo "Usage: ./push \"Your commit message\""
            exit 1
          fi
          git add .
          git commit -m "$1"
          git push
        '';
    git-commit = writeShellScriptBin "commit" ''
          if [ -z "$1" ]; then
            echo "Error: No commit message provided."
            echo "Usage: ./commit \"Your commit message\""
            exit 1
          fi
          git add .
          git commit -m "$1"
        '';

  in

{
  home.packages = [
    devel-templ
    git-commit
    git-push
    disable-wake
  ];
  
}
