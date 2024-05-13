{ pkgs, ... }: {
 
 programs.starship = {
    enable = true;
    enableZshIntegration = true;
    enableFishIntegration = false;
    settings = {
      kubernetes = {
        disabled = false;
      };
      aws = {
        disabled = false;
      };
      buf = {
        disabled = true;
      };
      character = {
        success_symbol = "[❯](bold green) ";
        error_symbol = "[✗](bold red) ";
      };
      directory = {
        truncate_to_repo = false;
      };
      git_branch = {
        symbol = " ";
        truncation_length = 18;
      };
      golang = {
        symbol = " ";
      };
      lua = {
        symbol = " ";
      };
      nix_shell = {
        symbol = " ";
      };
      package = {
        disabled = true;
      };
    };
  };
}
