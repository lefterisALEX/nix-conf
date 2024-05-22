 { pkgs, ... }: { 
 
  programs.eza = {
    enable = true;
    icons = true;
    git = true;
    enableFishIntegration  = true;
  };
  programs.fzf = {
    enable = true;
    enableFishIntegration = false;
  };

}
