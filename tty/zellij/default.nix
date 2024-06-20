{ inputs, pkgs, ...}:
{
  # home.packages = with pkgs; [
  #   zellij
  # ];
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
