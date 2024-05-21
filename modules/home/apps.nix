 { pkgs, ... }: { 
 
  programs.eza = {
    enable = true;
    icons = true;
    git = true;
  };
  programs.fzf = {
    enable = true;
    enableFishIntegration = false;
  };

}
