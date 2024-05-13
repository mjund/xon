{pkgs, ...}: {
  
  home = {
    file.".tmuxifier" = {
        recursive = true;
        source = pkgs.fetchFromGitHub {
          owner = "jimeh";
          repo = "tmuxifier";
          rev = "v0.13.0";
          sha256 = "1b6a1cw2mnml84k5vhbcp58kvp94xlnlpp4kwdhqw4jrzfgcjfzd";
        };
    };

    sessionPath = [
      "$HOME/.tmuxifier/bin"
    ];
  };
}
