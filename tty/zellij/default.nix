{ inputs, pkgs, ...}:
{
  programs.zellij = {
    enable = true;
    package = inputs.zellij.packages.${pkgs.system}.zellij;
    # enableZshIntegration = false;
    # settings = {
       # default_mode = "normal";
       # default_layout = "compact"; # previously "compact"
       # simplified_ui = true;
    #    pane_frames = false;
    #    scrollback_editor = "hx";
    #    theme = "tokyo-night-storm";
    #   session_serialization = false;
    # };
  };
}
