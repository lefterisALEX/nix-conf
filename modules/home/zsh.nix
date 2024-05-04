 { pkgs, ... }: { 
  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = false;
    oh-my-zsh = {
      enable = true;
      theme = "robbyrussell";
      plugins = [
        "git"
        "npm"
        "history"
        "node"
        "rust"
        "deno"
      ];
    };
    autocd = true;
    dotDir = ".config/zsh";
  };
}
