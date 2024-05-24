{ pkgs, ...}:
{
  programs.zellij = {
    enable = true;
    enableZshIntegration = true;
    settings = {
       default_mode = "normal";
       default_layout = "default_zjstatus"; # previously "compact"
       simplified_ui = true;
       pane_frames = false;
       scrollback_editor = "hx";
       theme = "tokyo-night-storm";
       session_serialization = false;
    };
  };
}
