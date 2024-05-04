 { pkgs, ... }: { 
  programs.fish = {
    enable = true;

    shellAliases = {
      gogit = "cd ~/git";
      "!!" = "eval \\$history[1]";
      lg = "ls -lG";
    };
    shellAbbrs = { 
      kt = "stern";
    }; 

};
}
