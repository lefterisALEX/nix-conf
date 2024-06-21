{ pkgs, ... }: {
 
 programs.starship = {
    enable = true;
    enableZshIntegration = true;
    enableFishIntegration = false;
  };
}
