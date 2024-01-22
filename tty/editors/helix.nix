{
  inputs,
  pkgs,
  config,
  ...
}: {
  imports = [./languages.nix];

  programs.helix = {
    enable = true;

    settings = {
      theme = "hex_lavender";
      editor = {
        completion-replace = false;
        line-number = "relative";
        bufferline = "multiple";
        color-modes = true;
        cursorline = true;
        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };
        indent-guides = {
          render = true;
          rainbow-option = "dim";
        };
        lsp.display-inlay-hints = true;
        statusline = {
          left = ["file-name" "file-modification-indicator" "version-control" ];
          center = ["file-type" "spinner" "diagnostics"];
          right = ["position-percentage" "total-line-numbers"];
          };
        true-color = true;
        whitespace.characters = {
          newline = "↴";
          tab = "⇥";
        };
      };

      keys.normal = {
        H = "goto_previous_buffer";
        L = "goto_next_buffer";
        esc = ["collapse_selection"  "keep_primary_selection"];
        space = {
          u = {
            f = ":format"; # format using LSP formatter
            w = ":set whitespace.render all";
            W = ":set whitespace.render none";
          };
        };

        ";" = {
        w = ":w";
        q = ":q";
        W = ":wq";
        r = ":config-reload";
        ";" = "command_mode";
        };

        "!" = {
        w = ":w!";
        q = ":q!";
        W = ":wq!";
          
        };

      };
    };
  };
}
