 { pkgs, ... }: { 
  programs.fish = {
    enable = true;
    shellInit = builtins.readFile ./config.fish;

    plugins = [
      # Enable a plugin (here grc for colorized command output) from nixpkgs
      { name = "grc"; src = pkgs.fishPlugins.grc.src; }
      #{ name = "tide"; src = pkgs.fishPlugins.tide.src; }
      # Manually packaging and enable a plugin
      {
        name = "z";
        src = pkgs.fetchFromGitHub {
          owner = "jethrokuan";
          repo = "z";
          rev = "e0e1b9dfdba362f8ab1ae8c1afc7ccf62b89f7eb";
          sha256 = "0dbnir6jbwjpjalz14snzd3cgdysgcs3raznsijd6savad3qhijc";
        };
      }
      {
        name = "bobthefisher";
        src = pkgs.fetchFromGitHub {
          owner = "Scrumplex";
          repo = "bobthefisher";
          rev = "f4179a14b087c7fbfc2e892da429adad40a39e44";
          sha256 = "sha256-l1DHSZa40BX2/4GCjm5E53UOeFEnMioWbZtCW14WX6k=";
        };
      }
    ];

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
