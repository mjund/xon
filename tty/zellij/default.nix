{ inputs, pkgs, ...}:

let 

  zell-forgot = pkgs.fetchurl { 
    url = "https://github.com/karimould/zellij-forgot/releases/download/0.4.0/zellij_forgot.wasm";
    sha256 = "1hzdvyswi6gh4ngxnplay69w1n8wlk17yflfpwfhv6mdn0gcmlsr";
    };
in
{

  home.file.".config/zellij/plugins/zell-forgot".source = zell-forgot;

  home.file.".config/zellij/config.kdl".text = ''

  default_shell "zsh"


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
