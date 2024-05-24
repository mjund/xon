{ inputs, pkgs, ... }:
{ 
  programs.tmux = {
    enable = true;
    tmuxinator.enable = true;
    plugins = with pkgs.tmuxPlugins; [
      {
# https://github.com/fcsonline/tmux-thumbs#user-content-configuration      
        plugin = tmux-thumbs;
        extraConfig = ''
        '';
      }
#       {
# # https://github.com/tmux-plugins/tmux-fpp
#         plugin = open;
#         extraConfig = ''
#         set -g @open 'x'
#         set -g @open-editor 'C-x'
#         set -g @open-B 'https://www.bing.com/search?q='
#         set -g @open-S 'https://www.google.com/search?q='
#         '';
#       }
      {
        plugin = tmux-fzf;
      }
      {
      # https://github.com/wfxr/tmux-fzf-url
        plugin = fzf-tmux-url;
        extraConfig = ''
          # set -g @fzf-url-bind 'x'
          set -g @fzf-url-fzf-options '-p 60%,30% --prompt="   " --border-label=" Open URL "'
          set -g @fzf-url-history-limit '2000'
        '';
      }
      # {
      # # https://github.com/dominikduda/tmux_mode_indicator
      # # https://github.com/MunifTanjim/tmux-mode-indicator
      # # https://github.com/tmux-plugins/tmux-prefix-highlight
      #   plugin = prefix-highlight;
      #   extraConfig = ''

      #     set -g @prefix_highlight_fg 'white' # default is 'colour231'
      #     set -g @prefix_highlight_bg 'blue'  # default is 'colour04'
          
      #      '';
      #  }
      #  {
      #   plugin = jump;
      #   extraConfig = ''
      #     set -g @jump-key ';'
      #     # keys will overlap with the word (default)
      #     set -g @jump-keys-position 'left'
      #     # keys will be at the left of the word without overlap
      #     set -g @jump-keys-position 'off_left'
      #     set -g @jump-bg-color '\e[0m\e[90m'
      #     set -g @jump-fg-color '\e[1m\e[31m'
      #   '';
      # }
      {
       # https://github.com/tmux-plugins/tmux-copycat
       # https://github.com/roosta/tmux-fuzzback
        plugin = extrakto;
        # extraConfig = ''
        #   set -g @extrakto_split_size "15"
        #   set -g @extrakto_clip_tool "xsel --input --clipboard" # works better for nvim
        #   set -g @extrakto_copy_key "tab"      # use tab to copy to clipboard
        #   set -g @extrakto_insert_key "enter"  # use enter to insert selection
        #   set -g @extrakto_fzf_unset_default_opts "false"  # keep our custom FZF_DEFAULT_OPTS
        #   set -g @extrakto_fzf_header "i c f g" # for small screens shorten the fzf header
        # '';
      }
      yank
      tilish
      {
        plugin = inputs.tmux-sessionx.packages.${pkgs.system}.default;
        extraConfig = ''
        set -g @sessionx-zoxide-mode 'on'
        set -g @sessionx-bind 'o'
        set -g @sessionx-window-height '85%'
        set -g @sessionx-window-width '75%'
        set -g @sessionx-preview-location 'right'
        set -g @sessionx-preview-ratio '55%'
        set -g @sessionx-filter-current 'false'

        set -g @sessionx-bind-tree-mode 'ctrl-w'
        set -g @sessionx-bind-new-window 'ctrl-c'
        set -g @sessionx-bind-kill-session 'ctrl-d'        '';
      }
    ];
    # prefix = "C-Space";
    baseIndex = 1;
    historyLimit = 10000;
    escapeTime = 0;
    keyMode = "vi";
    mouse = true;
    shell = "${pkgs.zsh}/bin/zsh";
    extraConfig = with builtins;
    readFile ./bindings.conf + readFile ./theme.conf + 
    readFile ./nav.conf    + readFile ./options.conf + 
    readFile ./extras.conf;
  };


}
