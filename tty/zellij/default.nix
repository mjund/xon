{ inputs, pkgs, ...}:

let 

  zell-forgot = pkgs.fetchurl { 
    url = "https://github.com/karimould/zellij-forgot/releases/download/0.4.0/zellij_forgot.wasm";
    sha256 = "1hzdvyswi6gh4ngxnplay69w1n8wlk17yflfpwfhv6mdn0gcmlsr";
    };
in
{


  home.file.".config/zellij/layouts/sys.kdl".text = ''
    layout { 
    	tab name="xon" cwd="/home/mon/xon" split_direction="horizontal" hide_floating_panes=true {
        floating_panes {
          pane name="rebld" command="bash" {
            args "-c" "tmux new-session -t rebld"
          }
        }
    		pane command="hx" borderless=true size="80%" {
          args "."
        }
    	}
    }
  '';
  home.file.".config/zellij/layouts/rebuild.kdl".text = ''
    layout { 
      floating_panes {
    		pane command="doas" name="rebuild" {
          args "nixos-rebuild switch --flake ~/xon/.#gix --impure"
          x 1
          y "80%"
          width 200
        }
       }
    	}
  '';

  home.file.".config/zellij/plugins/zell-forgot".source = zell-forgot;

  home.file.".config/zellij/config.kdl".text = ''

  default_shell "zsh"

  copy_command "wl-copy"                

  keybinds clear-default=true {
      // keybinds are divided into modes
      normal {
          // bind instructions can include one or more keys (both keys will be bound separately)
          // bind keys can include one or more actions (all actions will be performed with no sequential guarantees)
          bind "Ctrl f" { SwitchToMode "locked"; }
          bind "`" { SwitchToMode "tmux"; }
          bind "Ctrl p" { SwitchToMode "pane"; }
          bind "Alt n" { NewPane; }
          bind "Alt h" "Alt Left" { MoveFocusOrTab "Left"; }
          bind "Alt 1" { SwitchToMode "Tab"; GoToTab 1; SwitchToMode "Normal"; }
          bind "Alt 2" { SwitchToMode "Tab"; GoToTab 2; SwitchToMode "Normal"; }
          bind "Alt 3" { SwitchToMode "Tab"; GoToTab 3; SwitchToMode "Normal"; }
          bind "Alt 4" { SwitchToMode "Tab"; GoToTab 4; SwitchToMode "Normal"; }
          bind "Alt 5" { SwitchToMode "Tab"; GoToTab 5; SwitchToMode "Normal"; }
          bind "Alt 6" { SwitchToMode "Tab"; GoToTab 6; SwitchToMode "Normal"; }
          bind "Alt 7" { SwitchToMode "Tab"; GoToTab 7; SwitchToMode "Normal"; }
          bind "Alt 8" { SwitchToMode "Tab"; GoToTab 8; SwitchToMode "Normal"; }
      }
      pane {
          bind "h" "Left" { MoveFocus "Left"; }
          bind "l" "Right" { MoveFocus "Right"; }
          bind "j" "Down" { MoveFocus "Down"; }
          bind "k" "Up" { MoveFocus "Up"; }
          bind "p" { SwitchFocus; }
      }
      locked {
          bind "Ctrl f" { SwitchToMode "normal"; }
      }

  }
  '';
  programs.zellij = {
    enable = true;
    # package = pkgs.zellij;
    # enableZshIntegration = false;
    # settings = {
    #  # default_mode = "normal";
    #  # default_layout = "compact"; # previously "compact"
    #  # simplified_ui = true;
    #    default_shell = "zsh";
    #    pane_frames = false;
    #    scrollback_editor = "hx";
    #    theme = "tokyo-night-storm";
    #   session_serialization = false;
    # };
  };
}
