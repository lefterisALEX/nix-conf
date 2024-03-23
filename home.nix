{ config, pkgs, lib, ... }:
let
  isLinux = pkgs.stdenv.hostPlatform.isLinux;
  isDarwin = pkgs.stdenv.hostPlatform.isDarwin;
  unsupported = builtins.abort "Unsupported platform";
in
{
  imports = [
    ## Modularize your home.nix by moving statements into other files
  ];

  home.username = "lefteris";
  home.homeDirectory =
    if isLinux then "/home/lefteris" else
    if isDarwin then "/Users/lefteris" else unsupported;

  home.stateVersion = "23.11"; # Don't change this. This will not upgrade your home-manager.
  programs.home-manager.enable = true;
 
  programs.bash = {
    enable = true;
    shellAliases = {
      g = "git";
      lg = "lazygit";
  };
};
  programs.zsh = {
    enable = true;
    shellAliases = {
    g = "git";
    lg = "lazygit";
  };
};

  programs.fish = {
    enable = true;
    shellAliases = {
      g = "git";
      lg = "lazygit";
      lll = "ls -lrth";
    };
    plugins = [
      # Enable a plugin (here grc for colorized command output) from nixpkgs
      { name = "grc"; src = pkgs.fishPlugins.grc.src; }
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
    ];
};
    

  home.packages = with pkgs; ([
    # Common packages
    hello
  ] ++ lib.optionals isLinux [
    # GNU/Linux packages
  ]
  ++ lib.optionals isDarwin [
    # macOS packages
  ]);
}
