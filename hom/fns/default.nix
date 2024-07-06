
{ pkgs, ...}: 

let funcs = ''

 lam() {
    app=$1
    workspace=$2

    # Launch the application
    hyprctl dispatch exec $app

    # Wait for the application window to appear
    sleep 2

    # Move the application to the specified workspace
    hyprctl dispatch movetoworkspace $workspace,address:$(hyprctl activewindow -j | jq -r '.address')
}

'';
in
{
  programs.zsh.initExtra = funcs;
  programs.bash.initExtra = funcs;

}
  
