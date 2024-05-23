{ pkgs, lib, ... }:
let
  muxPath = ".config/tmuxinator";
in
{

home.packages = [
  # (import ../../pkgs/tmuxifier/default.nix { inherit pkgs lib; })
];


home.file.".tmux-layouts/wow.window.sh".text = ''


# Set window root path. Default is `$session_root`.
# Must be called before `new_window`.
window_root "~/Desktop"

# Create new window. If no argument is given, window name will be based on
# layout file name.
new_window "Example Window"

# Split window into panes.
split_v 20
run_cmd "watch -t date"
split_h 60

# Set active pane.
select_pane 0

'';
     


home.file."${muxPath}/play.yml".text = ''

name: c
root: ~/devel/

windows:
  - editor:
      root: ~/devel/learn/c
      layout: 7603,132x35,0,0[132x27,0,0,3,132x7,0,28{65x7,0,28,4,66x7,66,28,5}]
      # Synchronize all panes of this window, can be enabled before or after the pane commands run.
      # 'before' represents legacy functionality and will be deprecated in a future release, in favour of 'after'
      # synchronize: after
      panes:
        - hx .
        - watchexec -e c gcc -o showip main.c
        - watchexec ./showip www.google.com
'';
  
}
