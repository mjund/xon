{ pkgs, lib, ... }:
let
  muxPath = ".config/tmuxinator";
in
{

home.packages = [
  # (import ../../pkgs/tmuxifier/default.nix { inherit pkgs lib; })
];


home.file.".tmux-layouts/template.window.sh".text = ''
window_root "~/Desktop"
new_window "Example Window"
split_v 20
run_cmd "watch -t date"
split_h 60
select_pane 0

'';


home.file.".tmux-layouts/xon.window.sh".text = ''
window_root "~/xon"
new_window "xon"
split_v 70
select_pane 1
run_cmd "hx ."
split_h 60
run_cmd "hx ."
select_pane 1

'';
home.file.".tmux-layouts/ags.window.sh".text = ''
window_root "~/.config/ags"
new_window "ags"
split_v 70
run_cmd "watchexec -r -e js ags"
select_pane 1
run_cmd "hx ."
split_h 60
run_cmd "hx ."
select_pane 1

'';

home.file.".tmux-layouts/sys.session.sh".text = ''
if initialize_session "sys"; then

  load_window "xon"
  load_window "ags"

  select_window 1

fi
finalize_and_go_to_session

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
