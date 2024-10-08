{ pkgs, ...}: 

  with pkgs;
  let 

    reload = writeShellScriptBin "reload" ''

      pkill ags;
      ags&


        '';

    
    disable-wake = writeShellScriptBin "diswake" ''
    echo 'disabled' > '/sys/bus/usb/devices/3-1.4/power/wakeup';
    echo 'disabled' > '/sys/bus/usb/devices/2-1.8.2/power/wakeup';

    '';

    
    setxon = writeShellScriptBin "setxon" ''
     worksp nautilus special:files && worksp 'sakura -x "zellij --layout sys"' special:conf && worksp 'chromium "https://claude.ai" "https://chatgpt.com"' special:magic && worksp obsidian special:notes && worksp webcord special:chat &&  worksp betterbird special:mail && worksp todoist-electron special:tasks && worksp drawio special:diagram && worksp sakura special:ai && hyprctl dispatch togglefloating; hyprctl dispatch resizeactive exact 80% 20%; hyprctl dispatch centerwindow 
    '';

    worksp = writeShellScriptBin "worksp" ''


   lam() {

        # Extract the workspace argument (last argument)
        workspace="''${@: -1}"
        
        # Get all arguments except the last one (app command)
        app_command="''${@:1:$#-1}"
        
        # Launch the application
        hyprctl dispatch exec "$app_command"
        
        # Wait for the application window to appear
        sleep 3
        
        # Move the application to the specified workspace
        hyprctl dispatch movetoworkspace "$workspace",address:$(hyprctl activewindow -j | jq -r '.address')
    }

    # Check if at least two arguments are provided
    if [ $# -lt 2 ]; then
        echo "Usage: $0 <app_command> <workspace>"
        echo "Example: $0 \"firefox --arg 1 2 3\" workspace3"
        exit 1
    fi

    # Call the function with all provided arguments
    lam "$@"  

    '';

    
    devel-templ = writeShellScriptBin "dvd" ''

    doas ydotool key 42:1 110:1 110:0 42:0

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
    reload
    setxon
    worksp
    devel-templ
    git-commit
    git-push
    disable-wake
  ];
  
}
