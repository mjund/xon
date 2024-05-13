
# ▀█▀ █▀▄▀█ █░█ ▀▄▀ █ █▀▀ █ █▀▀ █▀█ 
# ░█░ █░▀░█ █▄█ █░█ █ █▀░ █ ██▄ █▀▄ 


_: { config, lib, pkgs, ... }:

{
  # Add options for tmuxifier, a terminal prompt
  options.tmuxifier.enable = lib.mkEnableOption "tmuxifier";

  # Install tmuxifier if desired
  config = lib.mkIf config.tmuxifier.enable {

    # Configure tmuxifier
    programs.tmuxifier = {
      enable = true;
    };

  };
}
