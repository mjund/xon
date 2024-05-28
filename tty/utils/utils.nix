{ inputs, pkgs, ...}: {

  home.packages = with pkgs; [

    watchexec
    inputs.devenv.packages."${pkgs.system}".devenv
    rclone
    rm-improved
    fd
    ripgrep
    cliphist
    powertop

  ];

  programs = {

  direnv = {
  enable = true;
  nix-direnv.enable = true;
  };

 # fd.enable = true;
  bat.enable = true;
  nix-index.enable = true;
  fzf = {
    enable = true;
    colors = {
      bg = "#24273a";
      "bg+" = "#363a4f";
      hl = "#ed8796";
      "hl+" = "#ed8796";
      fg = "#cad3f5";
      "fg+" = "#cad3f5";
      header = "#ed8796";
      info = "#c6a0f6";
      pointer = "#f4dbd6";
      marker = "#f4dbd6";
      prompt = "#c6a0f6";
      spinner = "#f4dbd6";
    };
    enableZshIntegration = true;
  };

  jq = {
    enable = true;
  };

  eza = {
    enable = true;
    icons = true;
    enableAliases = true;
  };

   zoxide = {
   enable = true;
   enableNushellIntegration = true;
   options = [];
 };

  ripgrep = {
    enable = true;
  };

};

}
