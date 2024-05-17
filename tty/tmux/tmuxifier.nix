{ pkgs, lib, ... }:
{


  home.sessionPath = [
      "$HOME/.tmuxifier/bin"
    ];


  home.file.".tmuxifier" = {
      recursive = true;
      source = pkgs.fetchFromGitHub {
        owner = "jimeh";
        repo = "tmuxifier";
        rev = "v0.13.0";
        sha256 = "1b6a1cw2mnml84k5vhbcp58kvp94xlnlpp4kwdhqw4jrzfgcjfzd";
      };
            };
  home.file.".tmuxifier/layouts/x.window.sh".text =
  
  ''
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

  home.file.".tmuxifier/layouts/x.session.sh".text =
  
  ''
  # Set a custom session root path. Default is `$HOME`.
# Must be called before `initialize_session`.
session_root "~/Documents"

# Create session with specified name if it does not already exist. If no
# argument is given, session name will be based on layout file name.
if initialize_session "Example Session"; then

  # Create a new window inline within session layout definition.
  new_window "In-line Window"
  tmux split-window -t "$session:$window.0" -v -p 50

  # Load a defined window layout.
  load_window "example"

  # Select the default active window on session creation.
  select_window 0

fi

# Finalize session creation and switch/attach to it.
finalize_and_go_to_session

   '';
  
  }
