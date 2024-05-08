 { pkgs, ... }: { 
 
  programs.eza = {
    enable = true;
    icons = true;
    git = true;
  };
  programs.awscli = {
    enable = true;
    # Default configuration file
    settings = {
      "default" = {
        region = "eu-west-1";
        output = "json";
      };
    };
    # Default credentials file
    credentials =  {};
  };
}
