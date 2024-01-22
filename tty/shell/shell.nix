{ lib, pkgs, config, ... }:
let

  aliases = {
    "db" = "distrobox";
    "arch" = "distrobox-enter Arch -- zsh";
    "fedora" = "distrobox-enter Fedora -- zsh";
    "eza" = lib.mkForce "eza -l --sort type --no-permissions --no-user --no-time --header --icons --no-filesize --group-directories-first";
    "tree" = "eza --tree";
    "ll" = lib.mkForce "eza -l";
    "nv" = "nvim";
    ":q" = "exit";
    "q" = "exit";
    "gs" = "git status";
    "gb" = "git branch";
    "gch" = "git checkout";
    "gc" = "git commit";
    "ga" = "git add";
    "gr" = "git reset --soft HEAD~1";
    "f" = "fzf --preview 'bat --color=always --style=numbers --line-range=:500 {}'";
    # "rm" = "gio trash";
    "upx" = "nixos-rebuild switch --flake /home/mon/xon#gix";
  };
  vault = {
    "vault" = "ga . && gc -m 'sync $(date '+%Y-%m-%d %H:%M')' && git push";
  };
  vault_nu = {
    "vault" = ''do { ga .; gc -m $"sync (^date '+%Y-%m-%d %H:%M')"; git push; }'';
  };
in
{ 
  programs = {
    thefuck.enable = true;

    
    zsh = {
    enable = true;
    enableCompletion = true;
    enableAutosuggestions = true;
    initExtra = ''
        SHELL=${pkgs.zsh}/bin/zsh
        zstyle ':completion:*' menu select
        bindkey "^[[1;5C" forward-word
        bindkey "^[[1;5D" backward-word
      '';
    shellAliases = aliases // vault;
    zplug = {
      enable = true;
      plugins = [
        { name = "zsh-users/zsh-autosuggestions"; }
      ];
      };
    
    };

    
    bash = {
      enable = true;
      initExtra = "SHELL=${pkgs.bash}";
      shellAliases = aliases // vault;
    };

    nushell = {
      enable = true;
      shellAliases = aliases // vault_nu;
      environmentVariables = {
        PROMPT_INDICATOR_VI_INSERT = "\"  \"";
        PROMPT_INDICATOR_VI_NORMAL = "\"∙ \"";
        PROMPT_COMMAND = ''""'';
        PROMPT_COMMAND_RIGHT = ''""'';
        NIXPKGS_ALLOW_UNFREE = "1";
        NIXPKGS_ALLOW_INSECURE = "1";
        SHELL = ''"${pkgs.nushell}/bin/nu"'';
      };
      extraConfig = ''
        $env.config = {
          show_banner: false
          edit_mode: vi
          shell_integration: true

          hooks: {
            pre_prompt: [{ null }]
            pre_execution: [{ null }]
          }

          table: {
            mode: rounded # compact, thin, rounded
            index_mode: never # always, auto
          }

          cursor_shape: {
            vi_insert: line
            vi_normal: block
          }

          menus: [{
            name: completion_menu
            only_buffer_difference: false
            marker: "? "
            type: {
              layout: columnar # list, description
              columns: 4
              col_padding: 2
            }
            style: {
              text: magenta
              selected_text: blue_reverse
              description_text: yellow
            }
          }]
        }
      '';
    };
  };
}
