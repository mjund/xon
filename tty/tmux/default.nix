{ inputs, pkgs, ... }:
let
  bg = "default";
  fg = "default";
  bg2 = "brightblack";
  fg2 = "white";
  color = c: "#{@${c}}";

  indicator = rec {
    accent = color "indicator_color";
    content = "  ";
    module = "#[reverse,fg=${accent}]#{?client_prefix,${content},}";
  };

  current_window = rec {
    accent = color "main_accent";
    index = "#[reverse,fg=${accent},bg=${fg}] #I ";
    name = "#[fg=${bg2},bg=${fg2}] #W ";
	flags = "#{?window_flags,#{window_flags}, }";
	module =  "${index}${name}";
  };

  window_status = rec {
    accent = color "window_color";
    index = "#[reverse,fg=${accent},bg=${fg}] #I ";
    name = "#[fg=${bg2},bg=${fg2}] #W ";
	flags = "#{?window_flags,#{window_flags}, }";
	module =  "${index}${name}";
  };

  time = rec {
    accent = color "main_accent";
    format = "%H:%M";

    icon = pkgs.writeShellScriptBin "icon" ''
      hour=$(date +%H)
      if   [ "$hour" == "00" ] || [ "$hour" == "12" ]; then printf "󱑖"
      elif [ "$hour" == "01" ] || [ "$hour" == "13" ]; then printf "󱑋"
      elif [ "$hour" == "02" ] || [ "$hour" == "14" ]; then printf "󱑌"
      elif [ "$hour" == "03" ] || [ "$hour" == "15" ]; then printf "󱑍"
      elif [ "$hour" == "04" ] || [ "$hour" == "16" ]; then printf "󱑎"
      elif [ "$hour" == "05" ] || [ "$hour" == "17" ]; then printf "󱑏"
      elif [ "$hour" == "06" ] || [ "$hour" == "18" ]; then printf "󱑐"
      elif [ "$hour" == "07" ] || [ "$hour" == "19" ]; then printf "󱑑"
      elif [ "$hour" == "08" ] || [ "$hour" == "20" ]; then printf "󱑒"
      elif [ "$hour" == "09" ] || [ "$hour" == "21" ]; then printf "󱑓"
      elif [ "$hour" == "10" ] || [ "$hour" == "22" ]; then printf "󱑔"
      elif [ "$hour" == "11" ] || [ "$hour" == "23" ]; then printf "󱑕"
      fi
    '' + "/bin/icon";

	module = "#[reverse,fg=${accent}] ${format} #(${icon}) ";
  };

  bat = rec {
    percentage = pkgs.writeShellScriptBin "percentage" ''
      path="/org/freedesktop/UPower/devices/DisplayDevice"
      percentage=$(${pkgs.upower}/bin/upower -i $path | grep percentage | awk '{print $2}' | tr '%' ' ')
      echo $percentage
    '' + "/bin/percentage";

    state = pkgs.writeShellScriptBin "state" ''
      path="/org/freedesktop/UPower/devices/DisplayDevice"
      state=$(${pkgs.upower}/bin/upower -i $path | grep state | awk '{print $2}')
      echo $state
    '' + "/bin/state";

    icon = pkgs.writeShellScriptBin "icon" ''
      percentage=$(${percentage})
      state=$(${state})
      if [ "$state" == "charging" ] || [ "$state" == "fully-charged" ]; then
          echo "󰂄"
      elif [ $percentage -ge 75 ]; then printf "󱊣"
      elif [ $percentage -ge 50 ]; then printf "󱊢"
      elif [ $percentage -ge 25 ]; then printf "󱊡"
      elif [ $percentage -ge 0  ]; then printf "󰂎"
      fi
    '' + "/bin/icon";

    color = pkgs.writeShellScriptBin "color" ''
      percentage=$(${percentage})
      state=$(${state})
      if [ "$state" == "charging" ] || [ "$state" == "fully-charged" ]; then
          echo "green"
      elif [ $percentage -ge 75 ]; then printf "green"
      elif [ $percentage -ge 50 ]; then printf "${fg2}"
      elif [ $percentage -ge 25 ]; then printf "yellow"
      elif [ $percentage -ge 0  ]; then printf "red"
      fi
    '' + "/bin/color";

    module = "#[fg=#(${color})]#(${icon}) #[fg=${fg}]#(${percentage})%";
  };

  pwd = rec {
    accent = color "main_accent";
    icon = "#[fg=${accent}] ";
    format = "#[fg=${fg}]#{b:pane_current_path}";
    module = "${icon}${format}";
  };
in
{ 

  home.packages = with pkgs; [ tmuxifier ];

  programs.tmux = {
    enable = true;
    plugins = with pkgs.tmuxPlugins; [
      # vim-tmux-navigator
      yank
      tilish

      # {
      #   plugin = inputs.tmux-sessionx.packages.${pkgs.system}.default;
      #   extraConfig = ''
      #   set -g @sessionx-zoxide-mode 'on'
      #   set -g @sessionx-bind 'o'
      #   '';
      # }
    ];
    prefix = "C-Space";
    baseIndex = 1;
    escapeTime = 0;
    keyMode = "vi";
    mouse = true;
    shell = "${pkgs.nushell}/bin/nu";
    extraConfig = builtins.readFile ./tmux.conf;
  };
}
